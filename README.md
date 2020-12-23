# Compute Options
Google Cloud Platform and Amazon Web Services offer a lot of ways to run a webapp.

When I am exploring the different technologies, I spin up a new "Hello World" instance, whether that means a cluster, an app, a function, or a Lambda. I do it with a script rather than the console, since I know I'm going to end up re-launching new instances as I learn the different possibilities.

These are those scripts. Each one is designed as the shortest script for  spinning up the Minimal Viable Instance. The script don't try out the varieity of functionalities offers on each platform, nor to they tear down the environments. They are just meant to get you to that comfortable milestone where "it works!" and from that point, you can incrementally add the functionalities  that you need.

They are generally based on the "good parts" of Quickstart tutorials for each technology, which I link to in each folder.

The scripts do not over every option. They focus on serverless platforms for web applications and APIs, which means AWS Elastic Beanstalk, Google App Engine, AWS Lambda, Cloud Functions, Cloud Run, and Elastic Container Service. I omitted Google Kubernetes Service and Elastic Kubernetes Service, as well as the IaaSes Elastic Campute Cloud and Google Compute Engine, seeing these as general-purpose rather than web-focused, but the distinction is arbitrary, and I'll be glad to add more as I get requests.

And beyond that, there are hundreds of other platforms outside GCP and AWS, if you choose to explore even further.

 The main prerequisites for running these scripts, you just

 