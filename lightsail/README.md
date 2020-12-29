# AWS Lightsail 

Prerequisites: An AWS account and the AWS CLI with credentials configured. You also need the [Lightsail plugin for the AWS CLI.]( https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-install-software)

This `deploy.sh` script pushes a container to Lightsail, but Lightsail allows you to skip that step if you deploy services from pre-defined containers.

The script is not rerunnable: It will fail on the second run if you do not clean up resources.

A [Getting Started article](https://aws.amazon.com/blogs/aws/lightsail-containers-an-easy-way-to-run-your-containers-in-the-cloud/) for Lightsail with containers is available. The article shows how to to it with the help of the console, but also entirely on the CLI.

