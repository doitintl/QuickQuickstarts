gcloud functions deploy hello --runtime python37 --trigger-http --allow-unauthenticated --region=us-east1

curl https://us-east1-$(gcloud config get-value project).cloudfunctions.net/hello
