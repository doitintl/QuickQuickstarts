# Web Backend Quickie-Quickie Start
When I try a new technology, I spin up a minimal instance. The goal is to reach that comfortable milestone where I can say "it works!" From that point, I incrementally add the functionalities that I want to explore.

There are a lot of different ways to run a webapp on Google Cloud Platform and Amazon Web Services. [Here are the scripts](https://github.com/doitintl/web_backends_hellos) that can help kick off your experimentation.

# The scripts 

## Automated

You can use the GUI for an initial poke-around, but scripts are better for the "Hello World," since you usually up deploying dozens of times as you tweak and add features. A script gives you reproducibility.

## Minimal

The script should be minimal: We are not trying off all aspects of each technology, just climbing up to the first level where something works.

## Complete

It should deploy everything needed including IAM roles, clusters, etc. Assuming command-line tools are installed, the goal is to launch *everything* that is needed.

Then, if something goes wrong, you can start from strach without figuring how to get each component into a stable state. 

The main prerequisites for running these scripts are `gcloud`, authenticated (with `gcloud init`; and the AWS CLI with credentials. You will need a default project/account set up. Lightsail requires a plugin for the AWS CLI and Elastic Beanstealk requires the `eb` tool. See the README in each directory for instructions. (Also, though the `ecs-cli` tool is needed for ECS, the script installs that for you.)

Some scripts also use `envsubst` (install it with the gettext package) and [`jq`](https://stedolan.github.io/jq/download/) for processing command output. Even without them the sequence of GCP and AWS commands shown in the script should be useful.

## Re-runnable

The script should preferably let you deploy new code and new features, overwriting the previous deployment without an error about collision with an existing resource. 

The attached scripts for GCP are re-runnable, but those for AWS are not, as this would have required complexity, and my first priority is to keep the scripts simple. I suggest you delete the old instance before redeploying; or you can launch each new version with a new name. (But watch out for costs!) 

## Coverage 
There are `deploy.sh` scripts for these, each in its own directory.
* AWS Elastic Beanstalk
* AWS Lambda
* Amazon Elastic Container Service
* Amazon Lightsail
* Google App Engine Standard Environment
* GCP Cloud Functions
* GCP Cloud Run

For the adventurous, you can run them all from a   `run_all.sh` in the root  directory. But first make sure to install the prerequisites mentioned in each `deploy.sh` file and Readme.

If you find this useful and want to see more, please submit a pull request with your script, or an issue asking for your favorite. 

Google Kubernetes Service and Elastic Kubernetes Service would be good next steps. as the Amazon EC2 and Google Compute Engine are possibilities, but we could also explore other cloud providers' offerings.

# More Reading
If you want an explanation of the steps to "Hello World," See the Quickstart and Getting Started article linked from each technology's README.

# Simplicity
Though it is tempting to use these scripts to compare the technologies, it's important to remember that they are not strictly comparable. Some are more managed, yet have less flexibility and breadth of functionality. Some require configuration files, but in doing so simplify the command line.

Still, if all you want is to get to Hello World,  the shortest scripts are those for Google's App Engine Standard Environment and Cloud Functions; in AWS,  Elastic Beanstalk is the simplest followed by Lightsail. 


 