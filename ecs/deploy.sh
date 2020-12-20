#!/bin/bash
ecs-cli --version 2>/dev/null
return_val=$?
echo $return_val
if [ "${return_val}" -ne 0 ]; then
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

ecs-cli --version 2>/dev/null || exit 127

#TODO try launch-type EC2 as well
REGION=us-east-1
aws iam --region $REGION create-role --role-name ecsTaskExecutionRole --assume-role-policy-document file://task-execution-assume-role.json
aws iam --region $REGION attach-role-policy --role-name ecsTaskExecutionRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy

ecs-cli configure --cluster helloworld-cluster --default-launch-type FARGATE --region $REGION --config-name helloworld-config
UP=$(ecs-cli up --cluster-config helloworld-config --ecs-profile -helloworld-profile --force)
export SUBNET1=$(echo $UP|egrep -o  -m1 "subnet-[0-9a-f]+"|head -n 1)
export SUBNET1=$(echo $UP|egrep -o  -m1 "subnet-[0-9a-f]+"|head -n 2|tail -n 1)
export VPC_ID=$(egrep -o   "vpc-[0-9a-f]+"|uniq)

security_group_id=$(aws ec2 describe-security-groups --filters Name=vpc-id,Values=${vpc_id} --region $REGION --output json --query 'SecurityGroups[?GroupName==`default`].GroupId'|tr -d '\[\]\"\n' )

aws ec2 authorize-security-group-ingress --group-id $security_group_id --protocol tcp --port 80 --cidr 0.0.0.0/0 --region us-west-2

ecs-cl compose --project-name helloworld-project service up --create-log-groups --cluster-config helloworld-config --ecs-profile helloworld-profile
