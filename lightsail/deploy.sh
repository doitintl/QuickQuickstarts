#!/bin/bash

# Prevents the output of  aws lightsail create-container-service-deployment from pausing at the end of a page.
export AWS_PAGER=""

export IMAGE=helloworld-lightsail
docker build -t $IMAGE .

# Prerequisite for Lightsail: Install the updated awscli tool  and install lightsail container plugin for AWS CLI https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-install-software
# Prerequisites for the text manipulation in this script: jq and envsubst

# Create Lightsail container service, and deploy image to it.
URL=$(aws lightsail create-container-service --service-name helloworld-service --power nano --scale 1 | jq -r '.containerService.url' )
PUSH_OUTPUT=$(aws lightsail push-container-image --service-name helloworld-service --image $IMAGE --label $IMAGE  )
export SVC_IMG=$(echo $PUSH_OUTPUT |sed -n  "s/^.*Refer to this image as \"\(.*\)\" in deployments\..*/\1/p" )

#Substitute SVC_IMG into the Lightsail configuration file
envsubst < lightsail-conf.json.template > lightsail-conf.json

# Deploy the container
aws lightsail create-container-service-deployment --cli-input-json file://lightsail-conf.json
# The service takes a while to be available.
while [[ -z "$(curl -I -L --silent  $URL |grep '200' )" ]];
do
    sleep 4
done

curl -L --silent $URL

echo "\n\n"

