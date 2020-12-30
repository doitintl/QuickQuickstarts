# Ten Web Backends First Steps
When I try a new technology, I spin up a minimal instance. The goal is to reach that comfortable milestone where I can say "it works!" From that point, I incrementally add the functionalities that I want to explore.

There are a lot of different ways to run a webapp on Google Cloud Platform and Amazon Web Services. [Here are the scripts](https://github.com/doitintl/web_backends_hellos) that can help kick off your experimentation with these web platforms.

1. AWS Elastic Beanstalk
2. AWS Lambda
3. Amazon Elastic Container Service
4. Amazon Lightsail
5. Google App Engine Standard Environment
6. Google App Engine Flexible Environment
7. GCP Cloud Functions
8. GCP Cloud Run
9. Google Kubernetes Engine

# The scripts 

## Automated

You can use the GUI for an initial poke-around, but scripts are better for the "Hello World," since you usually up deploying dozens of times as you tweak and add features. A script gives you reproducibility.

## Minimal

The script should be minimal: We are not trying off all aspects of each platform, just climbing up to the first level where something works.

## Complete

It should deploy everything needed including IAM roles, clusters, etc. Assuming command-line tools are installed, the goal is to launch *everything* that is needed.

Then, if something goes wrong, you can start from strach without figuring how to get each component into a stable state. 

The main prerequisites for running these scripts are `gcloud`, authenticated (with `gcloud init`; and the AWS CLI with credentials. You will need a default project/account set up. Lightsail requires a plugin for the AWS CLI and Elastic Beanstealk requires the `eb` tool. See the README in each directory for instructions. (Also, though the `ecs-cli` tool is needed for ECS, the script installs that for you.)

Some scripts also use `envsubst` (install it with the gettext package) and [`jq`](https://stedolan.github.io/jq/download/) for processing command output. Even without them the sequence of GCP and AWS commands shown in the script should be useful.

## Re-runnable

The script should preferably let you deploy new code and new features, overwriting the previous deployment without an error about collision with an existing resource. The re-run does not necessarily replace everything -- for example, a cluster may not be replaced --but your new code will be exposed.

The attached scripts for GCP are re-runnable, but those for AWS are not, as this would have required too much complexity. For these, I suggest you delete the old instance before redeploying; or you can launch each new version with a new name. (But watch out for costs!) 

## Coverage 
There are `deploy.sh` scripts for each platform, in the subdirectories.

For the adventurous, you can run them all from a   `run_all.sh` in the root  directory. But first make sure to install the prerequisites mentioned in each `deploy.sh` file and Readme.

If you find this useful and want to see more, please submit a pull request with your script, or an issue asking for your favorite. 

Elastic Kubernetes Service would be a good next steps, and then  EC2 and Google Compute Engine are possibilities, but we could also explore other cloud providers' offerings.

## Simplicity

I worked to keep the scripts as simple as possible, and in some platforms, like App Engine Standard Environment and Cloud Functions, the script is  just a single `deploy` command followed by access to a known URL

But some platforms, like Cloud Run and ECS, require building and pushing a container; and Lambda need an IAM role as well.

The code is mostly sequential commands, but in some platforms,  the output of one command needs to be parsed to get input into the next, and in some, the launch is non-blocking, so that the script has to poll until the platform is ready.

# More Reading
For an explanation of the steps to "Hello World," see the Quickstart and Getting Started article linked from each platforms's README. The `deploy.sh` scripts in the repository resemble the code embedded in these articles, but are even more stripped down.