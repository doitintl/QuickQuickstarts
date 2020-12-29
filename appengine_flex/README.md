# Google AppEngine Flexible Environment

Prerequisites: An initialized  `gcloud` CLI tool with a default project.

The script `deploy.sh` is re-runnable to deploy new code.  Note that it replaces an existing version as the default exposed service, so use this only on a development project over which you have full control.

The `app.yaml` is the minimal configuration file. If you want to reduce costs during development, add these lines (no indent).
```
 manual_scaling:
   instances: 1
 resources:
   cpu: 1
   memory_gb: 0.5
   disk_size_gb: 10
```

A [Quickstart article](https://cloud.google.com/appengine/docs/standard/python3/quickstart) for Python3 on App Engine Flexible Environment is available.

