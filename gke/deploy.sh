#!/bin/bash

IMAGE=helloworld-gke

gcloud builds submit --tag gcr.io/$(gcloud config get-value project )/$IMAGE

gcloud container clusters create helloworld-cluster --num-nodes=1
gcloud container clusters get-credentials helloworld-cluster
kubectl create deployment helloworld-deployment --image=gcr.io/$(gcloud config get-value project )/$IMAGE
kubectl expose deployment helloworld-deployment --type LoadBalancer --port 80 --target-port 8080


# The service takes a while to be available
while [ -z "$(kubectl get service helloworld-deployment -o jsonpath='{.status.loadBalancer.ingress[0].ip}' )" ]
do
    sleep 3
done
curl --silent $(kubectl get service helloworld-deployment -o jsonpath='{.status.loadBalancer.ingress[0].ip}' )

echo "\n\n"


