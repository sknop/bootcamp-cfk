# Preparations

## Deploy kind

If you do not have a Kubernetes cluster but a running Docker environment, you can use [kind](https://kind.sigs.k8s.io/)

Install kind, then create a cluster

    kind create cluster --name cfk --config ../kind-config.yaml

The config file opens a few ports for gateway APIs that might be useful later.

Change the kubectl context

    kubectl config use-context kind-cfk

You should also create a confluent namespace 

    kubectl create namespace confluent

I recommend to install [kubens](https://github.com/ahmetb/kubectx) to set contexts and change namespaces.

## Deploy Confluent for Kubernetes (CFK)

Set up the Helm Chart:

    helm repo add confluentinc https://packages.confluent.io/helm

Install Confluent For Kubernetes using Helm:

    helm upgrade --install operator confluentinc/confluent-for-kubernetes --namespace confluent

Check that the Confluent For Kubernetes pod comes up and is running:

    kubectl get pods --namespace confluent

## Scenarios

### PLAINTEXT

Simple [PLAINTEXT](/plaintext) implementation (no authentication or encryption) without a Gateway or Ingress Controller.

### SASL_PLAINTEXT/PLAIN

Simple [SASL_PLAINTEXT/PLAIN](/sasl_plain) implementation for PLAIN without TLS.

### TLS

[TLS](/tls) implementation with mTLS using the cert-manager.
