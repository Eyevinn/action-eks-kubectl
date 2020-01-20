#!/bin/sh

set -e
REGION=eu-north-1
CLUSTER=prod

export PATH=$PATH:/usr/local/bin/kubectl:/usr/local/bin/aws-iam-authenticator:/usr/local/bin/aws

aws eks --region $REGION update-kubeconfig --name $CLUSTER

kubectl $*
