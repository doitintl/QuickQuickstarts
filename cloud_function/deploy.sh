#!/bin/bash

REGION=us-east1
gcloud functions deploy hello --runtime python38 --trigger-http --allow-unauthenticated --region=$REGION

curl https://$REGION-$(gcloud config get-value project).cloudfunctions.net/hello
