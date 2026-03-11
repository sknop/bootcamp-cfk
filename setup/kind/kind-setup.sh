#!/bin/bash

# Kind setup

kind create cluster --name cfk --config ./kind-config.yaml

kubectl cluster-info --context kind-cfk

# Helm installations

## Install repos

helm repo add confluentinc https://packages.confluent.io/helm
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo add metallb https://metallb.github.io/metallb

helm repo update

## CFK

helm upgrade --install operator confluentinc/confluent-for-kubernetes --namespace confluent --create-namespace

## Cert-Manager (for SSL certs)

helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --version v1.19.2 \
    --set crds.enabled=true \
    --create-namespace

## Flink operator and CMF

helm upgrade --install cp-flink-kubernetes-operator confluentinc/flink-kubernetes-operator --namespace confluent

# For EKS, we will need to wait to have this deployed

helm upgrade --install cmf confluentinc/confluent-manager-for-apache-flink --namespace confluent

## MetalLB (load balancer)

helm upgrade --install metallb metallb/metallb --namespace metallb-system --create-namespace


# Switch to confluent namespace
kubens confluent
