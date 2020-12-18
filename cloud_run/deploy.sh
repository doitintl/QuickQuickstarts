#!/bin/bash
set -x
IMAGE=helloworld
SVC=helloworldservice
gcloud builds submit --tag gcr.io/$(gcloud config get-value project )/$IMAGE
gcloud run deploy $SVC  --image gcr.io/$(gcloud config get-value project )/$IMAGE --platform managed --region=us-east2 --allow-unauthenticated
URL=$(gcloud run services describe --platform managed $SVC --region us-east2 --format "value(status.address.url)" )
curl $URL
