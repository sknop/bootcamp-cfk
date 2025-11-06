# TLS secured Confluent Cluster with cert-manager

## Deploy cert-manager

https://artifacthub.io/packages/helm/cert-manager/cert-manager

Either

    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.18.2/cert-manager.crds.yaml

Or

    ## Add the Jetstack Helm repository
    helm repo add jetstack https://charts.jetstack.io --force-update

    ## Install the cert-manager helm chart
    helm install cert-manager --namespace confluent --version v1.18.2 jetstack/cert-manager

Or

    helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace confluent \
    --version v1.18.2 \
    --set crds.enabled=true

> [!TIP] 
> helm upgrade --install
>
> This is a better choice than helm install, since it is idempotent and allows for upgrades

## Deploy Flink Operator

    helm upgrade --install cp-flink-kubernetes-operator confluentinc/flink-kubernetes-operator

## Deploy

    kubectl apply -f confluent-platform-c3++.yaml    

## Cleanup

    kubectl delete -f    
    kubectl delete secret connect-tls controlcenter-tls kafka-tls kraft-tls ksqldb-tls schemaregistry-tls
