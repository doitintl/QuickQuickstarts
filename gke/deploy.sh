#!/bin/bash

IMAGE=gcr.io/$(gcloud config get-value project )/helloworld-gke
gcloud builds submit --tag $IMAGE

gcloud container clusters create helloworld-cluster --num-nodes=1
gcloud container clusters get-credentials helloworld-cluster

kubectl create deployment helloworld-deployment --image=$IMAGE

kubectl expose deployment helloworld-deployment --name helloworld-service --type LoadBalancer --port 80 --target-port 8080

# Wait for the service's external IP to be assigned.
for run in {1..10}; do
    IP=$(kubectl get service helloworld-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}' )
    [ -z "$IP" ] || break
    sleep 6
done

# Even after the service's IP is assigned, the service takes a few seconds to be available.
for run in {1..10}; do
    OUT=$(curl --silent $IP )
    [ -z "$OUT" ] || break
    sleep 6
done

echo $OUT

printf "\n\n"
