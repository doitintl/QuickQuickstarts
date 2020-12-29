# AWS Elastic Container Service

Prerequisites: An AWS Account and the AWS CLI with credentials configured. Also, you need the ecs-cli tool, but the `deploy.sh` script install that for you. 

The script `deploy.sh` is  not rerunnable: If you run it twice, the second time will fail.

This `deploy.sh` deploys to Fargate, but you can also choose EC2 as your platform.

A [Tutorial](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-cli-tutorial-fargate.html) for ECS on Fargate  with the CLI is available.
