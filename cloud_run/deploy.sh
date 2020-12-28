#!/bin/bash
REGION=us-east1
IMAGE=helloworld-cloudrun

# Submit build
gcloud builds submit --tag gcr.io/$(gcloud config get-value project )/$IMAGE

# Could run with --platform gke (or kubernetes)
gcloud run deploy helloworld-service --image gcr.io/$(gcloud config get-value project )/$IMAGE --platform managed --region=$REGION --allow-unauthenticated

URL=$(gcloud run services describe --platform managed helloworld-service --region $REGION --format "value(status.address.url)" )
curl $URL

echo "\n\n"

