#!/bin/bash

aws iam create-role --role-name lambda-hello --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

aws iam attach-role-policy --role-name lambda-hello --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

zip function.zip main.py

AWS_ACCOUNT=$(aws sts get-caller-identity --query Account --output text)

FUNCTION_NAME=hello

FUNCTION_ARN=$(aws lambda create-function --function-name ${FUNCTION_NAME} --zip-file fileb://function.zip --handler main.hello --runtime python3.7  --role arn:aws:iam::${AWS_ACCOUNT}:role/lambda-hello  --region us-east-1 --query FunctionArn  | awk -F\" '{ print $2 }' )

rm function.zip

#TODO instead of tr, head, tail, use jq
API_INFO=$(aws apigatewayv2 create-api --name hello-http-api --protocol-type HTTP --target ${FUNCTION_ARN} --query '[ApiEndpoint,ApiId]' | tr -d ',[]\" ' |tr '\n' ';')

API_ENDPOINT=$(echo $API_INFO | cut -d';' -f 2)
API_ID=$(echo $API_INFO | cut -d';' -f 3)


aws lambda add-permission \
  --statement-id statement$(( ( RANDOM % 10000 )  + 1 )) \
  --action lambda:InvokeFunction \
  --function-name "${FUNCTION_ARN}" \
  --principal apigateway.amazonaws.com \
  --source-arn arn:aws:execute-api:us-east-1:${AWS_ACCOUNT}:${API_ID}/*

curl $API_ENDPOINT


