#!/bin/bash
# Deploy to App Engine
gcloud app deploy -q

# Access the app at the predefined URL of the default service
curl http://$(gcloud config get-value project ).appspot.com

printf "\n\n"
