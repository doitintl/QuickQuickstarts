# Compute Options
Google Cloud Platform and Amazon Web Services offer a lot of ways to run a webapp. To choose one, you want to run a proof of concept.  When I do this, I like spin up a minimal "Hello World" instance, whether that means a cluster, an app, a function, or a Lambda. I do it with a script rather than the console, since I know I'm going to end up re-launching new instances as I learn the different possibilities.

These are those scripts. Each one is designed as the shortest script for  spinning up the Minimal Viable Instance and getting "Hello, World!" from a publicly accessible URL. The scripts don't try out the variety of functionalities  on each platform, nor do they tear down the environments. They are just meant to get you to that comfortable milestone where "it works!" and from that point, you can incrementally add the functionalities  that you need.

They are generally based on the "good parts" of Quickstart tutorials for each technology, which I link to in each folder.

The scripts do not over every option. They focus on serverless platforms for web applications and APIs, which means AWS Elastic Beanstalk, Google App Engine, AWS Lambda, Cloud Functions, Cloud Run, and Elastic Container Service. I omitted Google Kubernetes Service and Elastic Kubernetes Service, as well as the IaaSes Elastic Campute Cloud and Google Compute Engine, seeing these as general-purpose rather than web-focused, but the distinction is arbitrary, and I'll be glad to add more as I get requests.

And beyond that, there are hundreds of other platforms outside GCP and AWS, if you choose to explore even further.

The main prerequisites for running these scripts are `gcloud` and `aws` command-line tools, authenticated (with `gcloud init` and with aws credentials) and configured for a default project/account. Lightsail requires a plugin for the AWS CLI (see the README there for instructions), and ECS requires the `ecs-cli` tool (which the script installs).

Some scripts also use the `envsubst`  (install gettext package) and [`jq`](https://stedolan.github.io/jq/download/)  for processing command output to get variables to input for the next command. These are useful tools to have around, but if you don't have access to them, you can still use the same sequence of GCP and AWS command and extract necessary variables in another way.

Which are the simplest to get started with? Though some technologies require configuration files as well, let's look at the scripts as these can process config files for you.=

Complexity varies according to whether the service is global or requires a region; whether it can use the code directly  or requires zipping it or building a Docker container; whether it pushes directly to the cloud or requires you to push to a repository first, whether it transparently creates the roles, permissions, and networking, or makes you process these or create them.

The shortest scripts are those for Google's App Engine and Cloud Functions, with  Cloud Run adding  code to build a container. 

In AWS, Elastic Beanstalk is the simplest followed by   Lightsail.  Lambda is surprisingly complex given that the product's selling point is that it is fully managed:  You need to set up the IAM role and policy; zip up the code; create the function; and to expose it you ned an API Gateway and permissions for the Gateway. ECS is the most complex, but that is not surprising for a more generic compute model that manages less of the environment for you.

Yuu can run the  `deploy.sh` in each subdirectory, or `run_all.sh` in this directory. But first check out the prerequisites mentioned in each `deploy.sh` file and Readme.



 