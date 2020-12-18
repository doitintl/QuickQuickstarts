#!/bin/bash

IMAGE=hello-world
SVC=hello-world-service

docker build -t $IMAGE .

# Prerequisite: Install the updated awscli tool  and install lightsail container plugin for AWS CLI https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-install-software
URL=$(aws lightsail create-container-service --service-name $SVC --power nano --scale 1 | jq -r '.containerService.url' )

PUSH_OUTPUT=$(aws lightsail push-container-image --service-name $SVC --image $IMAGE --label $IMAGE )
SVC_IMG=$(echo $PUSH_OUTPUT |sed -n  "s/^.*Refer to this image as \"\(.*\)\" in deployments\..*/\1/p" )


read -r -d '' LIGHTSAIL_CONF_JSON <<-EOT
 {
      "serviceName": "$SVC",
      "containers": {
         "$IMAGE": {
            "image": "$SVC_IMG",
            "ports": {
               "8080": "HTTP"
            }
         }
     },
     "publicEndpoint": {
        "containerName": "$IMAGE",
        "containerPort": 8080
     }
  }
EOT

echo $LIGHTSAIL_CONF_JSON | jq . > lightsail-conf.json

aws lightsail create-container-service-deployment --cli-input-json file://lightsail-conf.json

while [ -n "$(curl -L --silent $URL |grep 404)" ];
do
    sleep 1
done

curl -L --silent $URL
