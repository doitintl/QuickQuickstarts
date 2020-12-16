#!/bin/bash
STDERR=$(gcloud app deploy -q 2>&1 >/dev/null )
URL=$(echo $STDERR | sed -n  "s/Deployed service \[default\] to \[\(.*\)\]/\1/p" )
curl $URL
