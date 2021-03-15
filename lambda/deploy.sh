#!/bin/bash

# Create  the role that the Lambda runs with, and attach  a policy to  that role.
aws iam create-role --role-name helloworld-lambda --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

aws iam attach-role-policy --role-name helloworld-lambda --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

#  Zip up the code for delivery to Lambd
zip function.zip main.py

# Get the ID of your currently set AWS account.
AWS_ACCOUNT=$(aws sts get-caller-identity --query Account --output text)

FUNCTION_NAME=helloworld
REGION=us-east-1

# Create the function, and extract the ARN.
FUNCTION_ARN=$(aws lambda create-function --function-name ${FUNCTION_NAME} --zip-file fileb://function.zip --handler main.helloworld --runtime python3.7  --role arn:aws:iam::${AWS_ACCOUNT}:role/helloworld-lambda  --region $REGION --query FunctionArn  | awk -F\" '{ print $2 }' )

rm function.zip

# Create the API in API Gateway.
API_INFO=$(aws apigatewayv2 create-api --name helloworld-http-api --protocol-type HTTP --target ${FUNCTION_ARN} --query '[ApiEndpoint,ApiId]' )

# Extract the API ID (to be used for granting permission) and its Endpoint (URL).
URL=$(echo $API_INFO | jq -r '.[0]')
API_ID=$(echo $API_INFO | jq -r '.[1]')

# Allow the API to access the Lambda
aws lambda add-permission \
  --statement-id statement$(( ( RANDOM % 10000 )  + 1 )) \
  --action lambda:InvokeFunction \
  --function-name "${FUNCTION_ARN}" \
  --principal apigateway.amazonaws.com \
  --source-arn arn:aws:execute-api:${REGION}:${AWS_ACCOUNT}:${API_ID}/* \
  --region $REGION

#Access the Lambda through the API Gateway
curl $URL

printf "\n\n"
