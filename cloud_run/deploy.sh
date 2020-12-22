#!/bin/bash

IMAGE=helloworld-cloudrun
SVC=helloworldservice
gcloud builds submit --tag gcr.io/$(gcloud config get-value project )/$IMAGE

# Could run with --platform gke (or kubernetes)
gcloud run deploy $SVC --image gcr.io/$(gcloud config get-value project )/$IMAGE --platform managed --region=us-east2 --allow-unauthenticated
URL=$(gcloud run services describe --platform managed $SVC --region us-east2 --format "value(status.address.url)" )
curl $URL
