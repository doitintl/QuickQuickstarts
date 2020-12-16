#!/bin/bash
# Deploy, capturing standard error, from which we pull the URL.
STDERR=$(gcloud app deploy -q 2>&1 >/dev/null )
URL=$(echo $STDERR | sed -n  "s/Deployed service \[default\] to \[\(.*\)\]/\1/p" )
curl $URL
