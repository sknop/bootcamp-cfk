# SASL_PLAINTEXT/PLAIN example

## Strategy

Inject the username/password into Kubernetes secrets and refer these secrets in the deployment.
You can either:

Inject the secret using this:

    kubectl create secret generic credential \
    --from-file=plain-users.json=./plain-users.json \
    --from-file=plain-interbroker.txt=./plain-kafka.txt \
    --from-file=kafka-server-listener-internal-plain-metrics.txt=./plain-kafka.txt \
    --from-file=plain.txt=./plain-kafka.txt --namespace confluent

    kubectl create secret generic credential-cp \
    --from-file=plain.txt=./plain-kafka.txt --namespace confluent

Alternatively, split the authentication for each service into separate configuration files 

    kubectl create secret generic credential \
    --from-file=plain-users.json=./plain-users.json \
    --from-file=plain-interbroker.txt=./plain-kafka.txt \
    --from-file=kafka-server-listener-internal-plain-metrics.txt=./plain-kafka.txt \
    --from-file=plain.txt=./plain-kafka.txt \
    --namespace confluent

    kubectl create secret generic credential-cp \
    --from-file=connect-client-plain.txt=./plain-connect.txt \
    --from-file=schemaregistry-client-plain.txt=./plain-schema-registry.txt \
    --from-file=ksqldb-client-plain.txt=./plain-ksqldb.txt \
    --from-file=kafkarestproxy-client-plain.txt=./plain-rest-proxy.txt \
    --from-file=controlcenter-client-plain.txt=./plain-control-center.txt \
    --namespace confluent

**Or even better:**

    kubectl apply -k .

There is a new kustomization file that simplifies generation of the secrets.
