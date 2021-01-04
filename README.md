# Web Backends First Steps
Google Cloud Platform and Amazon Web Services have many different infrastructures for running a webapp. 
When I try a new  one, I spin up a minimal instance from the command line. I just want to reach
that comfortable milestone where I can say "it works!" 

Then, I incrementally add the functionalities that I want to explore.

#  Design principles 

## Automated

The GUI is good for an initial poke-around, but scripts are better for the "Hello, World!" stage,
so you can repeatedly deploy the same service while you tweak and add features.

## Minimal
"Hello, World!" scripts are minimal: The least code needed for getting the HTTP response.

## Complete

The scripts deploy everything needed including IAM roles, clusters, etc. 
The only prerequisites are command-line tools and authentication to a cloud account. 
With that in place, the goal is to launch *everything* that is needed.
Then, if something goes wrong, you can start from scratch without figuring how 
to get each component into a stable state.  

Preferably, the scripts are re-runnable, allowing you to deploy new code on top of a previous deployment.
Some of the scripts here are, but some aren't, where adding that capability would add too much code. For these,
the old instance before re-deploying; or launch each new version with a new name. (But watch out for costs! 
Delete the old instances as soon as possible.)  


## Prerequisites

The README for each directory describes the prerequisites. These include
* `gcloud`, authenticated (with `gcloud init`)
* The AWS CLI tool with credentials. 
* A plugin to the AWS CLI tool for Lightsail
* The Elastic Beanstalk  `eb` tool. 
* The `ecs-cli` tool for ECS, but the script installs that for you.
* For processing command output, some require
    * `envsubst` (install it with the `gettext` package) 
    * [`jq`](https://stedolan.github.io/jq/download/)


# The supported infrastructures    
[Here are the scripts](https://github.com/doitintl/web_backends_hellos) that I created for 
1. AWS Elastic Beanstalk
2. AWS Lambda
3. Amazon Elastic Container Service
4. Amazon Lightsail
5. Google App Engine Standard Environment
6. Google App Engine Flexible Environment
7. GCP Cloud Functions
8. GCP Cloud Run
9. Google Kubernetes Engine
## Scripts

There are `deploy.sh` scripts for each platform, in the subdirectories.

For the adventurous, you can run them all from `run_all.sh` in the root  directory. 

If you find this useful and want to see more, please submit a pull request with your script, or an issue asking for your favorite. 

Elastic Kubernetes Service would be a good next step, 
and then  EC2 and Google Compute Engine and other cloud providers' offerings.

## Simplicity

In App Engine Standard Environment and Cloud Functions, the
script is  just a single `deploy` command followed by access to a known URL.

Some infrastructures add more complexity. For example,
Cloud Run and ECS require building and pushing a container;
and Lambda needs an IAM role as well.

The code is mostly sequential commands, but in some cases,
the output of one command needs to be parsed to get input into the next, or
a loop is needed to wait for a non-blocking initalization to finish.

# More Reading
For an explanation of the steps to "Hello, World!" see the
Quickstart and Getting Started article linked in each README. These often have their
own "Hello, World!" script, but sometimes a bit more complex than what is on offer 
[here](https://github.com/doitintl/web_backends_hellos).
