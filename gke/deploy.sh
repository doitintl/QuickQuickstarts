#!/bin/bash

sed  "s/__BUILDTIME__/$(date -u)/" main.py.template > main.py
IMAGE=helloworld-gke:$(date +%s)
IMAGE_GCR=gcr.io/$(gcloud config get-value project )/$IMAGE
gcloud builds submit --tag $IMAGE_GCR

gcloud container clusters create helloworld-cluster --num-nodes=1
gcloud container clusters get-credentials helloworld-cluster

if [ -z $(kubectl get deployment helloworld-deployment -o name) ]; then
    kubectl create deployment helloworld-deployment --image=$IMAGE_GCR
else
   kubectl set image deployment/helloworld-deployment  helloworld-gke=$IMAGE_GCR
fi

kubectl expose deployment helloworld-deployment --type LoadBalancer --port 80 --target-port 8080

# The service takes a while to be available
while [ -z "$(kubectl get service helloworld-deployment -o jsonpath='{.status.loadBalancer.ingress[0].ip}' )" ]
do
    sleep 3
done
sleep 3

curl --silent $(kubectl get service helloworld-deployment -o jsonpath='{.status.loadBalancer.ingress[0].ip}' )

printf "\n\n"
