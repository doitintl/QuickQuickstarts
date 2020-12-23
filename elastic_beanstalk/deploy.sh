#!/bin/bash
# Pre-requisite: Elastic Beanstalk eb command-line tool. See https://github.com/aws/aws-elastic-beanstalk-cli-setup
set -x

REGION=us-east-1
eb init -p python-3.6 helloworld-app2 --region $REGION

ENV_CREATION_OUTPUT=$(eb create helloworld-env2 )

URL=$(echo $ENV_CREATION_OUTPUT | sed -n "s/^.*Application available at \([a-z.0-9-]*\). .*$/\1/p" )

# The environment takes a while to be available
while [ -z "$(curl --silent $URL)" ]
do
    sleep 3
done
curl --silent $URL
