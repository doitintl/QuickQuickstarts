#!/bin/bash

# Install the ecs-cli command line tool if needed
ecs-cli --version 2>/dev/null

if [ "$?" -ne 0 ]; then
    if [ "$(uname)" == "Linux" ] ; then
        sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
    elif [ "$(uname)" == "Darwin" ] ; then
        sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-darwin-amd64-latest
    else
        echo "unknown uname $(uname)"
    fi
    sudo chmod +x /usr/local/bin/ecs-cli
else
    echo "ecs-cli available"
fi

export REGION=us-east-1

# Check that the tool was installed
ecs-cli --version 2>/dev/null || exit 127

# Build image and push to ECR
docker build -t hello-world-ecs .
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text).dkr.ecr.${REGION}.amazonaws.com
aws ecr create-repository --repository-name hello-world-ecs --image-scanning-configuration scanOnPush=true --region $REGION
docker tag hello-world-ecs:latest $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$REGION.amazonaws.com/hello-world-ecs:latest
docker push $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$REGION.amazonaws.com/hello-world-ecs:latest


# set up the IAM to execute tasks
aws iam --region $REGION create-role --role-name ecsTaskExecutionRole --assume-role-policy-document file://task-execution-assume-role.json
aws iam --region $REGION attach-role-policy --role-name ecsTaskExecutionRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy

# Configure the ECS cluster
ecs-cli configure --cluster helloworld-cluster --default-launch-type FARGATE --region $REGION --config-name helloworld-config

# Launch the cluster.  Add a --force parameter to allow deploying new versions of code under the same configuration. (However the preceding lines are not rerunnable in the same way.)
CLUSTER_OUTPUT=$(ecs-cli up --cluster-config helloworld-config --ecs-profile helloworld-profile  )

# Get networking info for  the cluster, using the output of the cluster-creation command
export SUBNET1=$(echo $CLUSTER_OUTPUT | egrep -o  -m1 "subnet-[0-9a-f]+" | head -n 1 )
export SUBNET2=$(echo $CLUSTER_OUTPUT | egrep -o  -m1 "subnet-[0-9a-f]+" | tail -n 1 )
export VPC_ID=$(echo $CLUSTER_OUTPUT |  egrep -o  -m1 "vpc-[0-9a-f]+" )
export SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filters Name=vpc-id,Values=${VPC_ID} --region $REGION --output json --query 'SecurityGroups[?GroupName==`default`].GroupId'|tr -d '\[\]\"\n ' )
export IMAGE=$(aws sts get-caller-identity --query Account --output text).dkr.ecr.$REGION.amazonaws.com/hello-world-ecs:latest

# Substitute IMAGE, REGION, SUBNET1, SUBNET2 into the config files
envsubst < ecs-params.yml.template > ecs-params.yml
envsubst <  docker-compose.yml.template > docker-compose.yml

# Authorize ingress
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $REGION

# Launch the ECS service
ecs-cli compose --project-name helloworld-project service up --create-log-groups --cluster-config helloworld-config --ecs-profile helloworld-profile --region $REGION

# Find the address of the service that was just launched
ADDRESS=$(ecs-cli compose --project-name helloworld-project service ps --cluster-config helloworld-config --ecs-profile helloworld-profile  --region $REGION  |tail -n 1|awk '{ print $3 }' |cut -d'-' -f 1 )
curl $ADDRESS

printf "\n\n"
