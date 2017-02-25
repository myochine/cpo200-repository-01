#! /bin/bash
#
# File: build.sh
#
# Purpose: Drive the building of a Google Compute Engine image
#          using the guestbook Docker container
#
# Requires: The environment variable GCR_PREFIX must be set to the Google Container Registery
#           prefix (such as us.gcr.io, eu.gcr.io, asia.gcr.io)

if [ -z "$GCR_PREFIX" ]; then
    echo "Need to set GCR_PREFIX"
    exit 1
fi  


# Issue a request for the metadata service to get the current project identifier
export PROJECT_ID=$(curl -s 'http://metadata/computeMetadata/v1/project/project-id' -H 'Metadata-Flavor: Google')

gcloud compute images delete guestbook-image --quiet --user-output-enabled false

# Run Packer to build the image
/opt/packer/packer build  compute-image-build.json
