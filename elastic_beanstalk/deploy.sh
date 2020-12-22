#!/bin/bash

# Pre-requisite: Elastic Beanstalk eb command-line tool. See https://github.com/aws/aws-elastic-beanstalk-cli-setup

eb init -p python-3.6 flask-app --region us-east-1

ENV_CREATION_OUTPUT=$(eb create flask-env )

URL=$(echo $ENV_CREATION_OUTPUT | sed -n "s/^.*Application available at \([a-z.0-9-]*\). .*$/\1/p" )

# The environment takes a while to be available
while [ -z "$(curl --silent $URL )" ]
do
    sleep 1
done

curl --silent $URL
