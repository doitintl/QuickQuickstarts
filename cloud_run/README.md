# Google Cloud Run

Prerequisite: An initialized  `gcloud`  with default project. 

The script `deploy.sh` is idempotent.

This `deploy.sh` runs the container on the "managed" platform, but you could aloso run it on Google Kubernetes Engine or Anthos ("Kubernetes"). It deploys your container straight to Cloud Run, but a more common flow is to deploy it to Google Container Registry.

A [Quickstart article](https://cloud.google.com/run/docs/quickstarts/build-and-deploy) for Google Cloud Run is available.