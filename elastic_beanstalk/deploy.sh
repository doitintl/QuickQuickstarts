#!/bin/bash

# Must install eb tool first. See https://github.com/aws/aws-elastic-beanstalk-cli-setup

eb init -p python-3.6 flask-application --region us-east-1

OUTPUT=$(eb create flask-environment)

URL=$(echo $OUTPUT | sed -n "s/^.*Application available at \([a-z.0-9-]*\). .*$/\1/p" )

CURL_OUT=$(curl $URL)
while [ -z "$CURL_OUT" ]
do
    CURL_OUT=$(curl $URL )
    sleep 10
done
echo $CURL_OUT
