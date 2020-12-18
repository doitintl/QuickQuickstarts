#!/bin/bash
gcloud app deploy -q

SVC=default
curl http://${SVC}-dot-$(gcloud config get-value project ).appspot.com
