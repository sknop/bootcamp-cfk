# Modular design

## Motivation

This particular design is born out of the frustration of never having the right version of containers 
or the desired security settings. Kubernetes Kustomization should make it possible to build up
the configurations as components, allowing us to use a stackable setup for different setups.

## Components

The individual components and their required changes can be found in the **components** directory. Each component
can be used independently, or at least this is the design goal.

When new configurations are available due to engineering changes, it should be possible to just create
a new component, and then update or design a new cluster configuration plugging together the desired components.

## Version

The particular container versions are in the individual **kustomization.yaml** file in the **clusters** directory.
This means there is *one* place to upgrade versions for any possible configuration. 

## Development vs Production

The only difference for now between development vs production is the requirement for a proper Confluent license
as a text file. This license needs to be deployed as a secret as explained 
in the [clusters/production/README.md](clusters/production/README.md) file.

## Required preliminary steps


### Install your Kubernetes setup, for example Kind

### Install Confluent Operator

Set up the Helm Chart:

    helm repo add confluentinc https://packages.confluent.io/helm

Install Confluent For Kubernetes using Helm:

    helm upgrade --install operator confluentinc/confluent-for-kubernetes --namespace confluent

## Install TLS CA and certificates

    kubectl apply -f assets/tls/ca-issuer.yaml # will install in the cert-manager namespace
    kubectl apply -f assets/tls/certificates.yaml

## Testing

A useful tool is yq (like jq, just for yaml):

    sudo apt install -y yq

Then the output of kustomize can be tested like this

    kubectl kustomize clusters/production/tls | yq

