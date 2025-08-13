# Preparations

## Deploy Confluent for Kubernetes (CFK)

Set up the Helm Chart:

    helm repo add confluentinc https://packages.confluent.io/helm

Install Confluent For Kubernetes using Helm:

    helm upgrade --install operator confluentinc/confluent-for-kubernetes --namespace confluent

Check that the Confluent For Kubernetes pod comes up and is running:

    kubectl get pods --namespace confluent

## Scenarios

### PLAINTEXT

Simple PLAINTEXT implementation (no authentication or encryption) without a Gateway or Ingress Controller

### SASL_PLAINTEXT/PLAIN

