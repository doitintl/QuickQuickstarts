#!/bin/bash

REGION=us-east1

# Deploy the function
gcloud functions deploy hello --runtime python38 --trigger-http --allow-unauthenticated --region=$REGION

# Access the Cloud Function at the default URL
curl https://$REGION-$(gcloud config get-value project).cloudfunctions.net/hello

echo "\n\n"

