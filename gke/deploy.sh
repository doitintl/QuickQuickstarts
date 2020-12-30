#!/bin/bash
set -x

IMAGE=gcr.io/$(gcloud config get-value project )/helloworld-k8s
gcloud builds submit --tag $IMAGE

gcloud container clusters create helloworld-cluster-1 --num-nodes=1
gcloud container clusters get-credentials helloworld-cluster-1

# Allow rerunning the script; create a deployment if there is not one yet, otherwise update the deployment.
if [ -z $(kubectl get deployment helloworld-deployment-1 -o name) ]; then
    kubectl create deployment helloworld-deployment-1 --image=$IMAGE
else
   kubectl set image deployment/helloworld-deployment-1  helloworld-gke=$IMAGE
fi

kubectl get deployment helloworld-deployment-1
kubectl expose deployment helloworld-deployment-1 --name helloworld-service-1 --type LoadBalancer --port 80 --target-port 8080

# Wait for the service's external IP to be assigned
while : ; do
    sleep 3
    IP=$(kubectl get service helloworld-service-1 -o jsonpath='{.status.loadBalancer.ingress[0].ip}' )
    [ -z "$IP" ] || break
done

# Even after the service's IP is assigned, the service takes time to be available. Give up after 15 seconds.
for run in {1..5}; do
    OUT=$(curl --silent $IP )
    [ -z "$OUT" ] || break
    sleep 3
done
echo $OUT
printf "\n\n"
