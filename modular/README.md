# Modular design

## Motivation

## Components

## Version

## Development vs Production

## Required preliminary steps

### Install your Kubernetes setup, for example Kind

### Install Confluent Operator

Set up the Helm Chart:

    helm repo add confluentinc https://packages.confluent.io/helm

Install Confluent For Kubernetes using Helm:

    helm upgrade --install operator confluentinc/confluent-for-kubernetes --namespace confluent


## Testing

A useful tool is yq (like jq, just for yaml):

    sudo apt install -y yq

Then the output of kustomize can be tested like this

    kubectl kustomize clusters/production/tls | yq

