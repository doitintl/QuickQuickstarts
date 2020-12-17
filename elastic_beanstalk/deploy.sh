#!/bin/bash

# Must install eb tool first. See https://github.com/aws/aws-elastic-beanstalk-cli-setup

eb init -p python-3.6 flask-app --region us-east-1

OUTPUT=$(eb create flask-env )

URL=$(echo $OUTPUT | sed -n "s/^.*Application available at \([a-z.0-9-]*\). .*$/\1/p" )


while [ -z "$(curl --silent $URL )" ]
do
    sleep 1
done

curl --silent $URL
