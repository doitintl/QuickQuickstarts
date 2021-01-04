# AWS Elastic Beanstalk

Prerequisites: The AWS CLI tool configured with credentials to an AWS account,
and the Elastic Beanstalk  command-line tool [eb](https://github.com/aws/aws-elastic-beanstalk-cli-setup).

The script `deploy.sh` is _not_ rerunnable: It will fail on the second run 
if you don't clean up resources.

[An article](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create-deploy-python-flask.html) on deploying a Flask application to EB from the command-line is available.
