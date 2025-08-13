Need to inject the secret using this:

    kubectl create secret generic credential \
    --from-file=plain-users.json=./plain-users.json \
    --from-file=plain-interbroker.txt=./plain-kafka.txt \
    --from-file=plain.txt=./plain-kafka.txt --namespace confluent

    kubectl create secret generic credential-cp \
    --from-file=plain.txt=./plain-kafka.txt --namespace confluent

Split into separate configuration files for each service

    kubectl create secret generic credential \
    --from-file=plain-users.json=./plain-users.json \
    --from-file=plain-interbroker.txt=./plain-kafka.txt \
    --from-file=plain.txt=./plain-kafka.txt \
    --namespace confluent

    kubectl create secret generic credential-cp \
    --from-file=connect-client-plain.txt=./plain-connect.txt \
    --from-file=schemaregistry-client-plain.txt=./plain-schema-registry.txt \
    --from-file=ksqldb-client-plain.txt=./plain-ksqldb.txt \
    --from-file=kafkarestproxy-client-plain.txt=./plain-rest-proxy.txt \
    --from-file=controlcenter-client-plain.txt=./plain-control-center.txt \
    --namespace confluent

Deploy cluster

    kubectl apply -f confluent-platform-c3++.yaml

Create producer and consumer configs

    kubectl create secret generic \
    kafka-client-config --from-file=producer.properties --from-file=consumer.properties

Verify client is working 

    kubectl exec -it kafka-client-0 -- bash

    kafka-topics --list --bootstrap-server kafka:9071 --command-config /etc/kafka-config/producer.properties

Cleanup

    kubectl delete -f confluent-platform-c3++.yaml
    kubectl delete secret kafka-client-config
    kubectl delete secret credential
    kubectl delete secret credential-cp

Debugging hints

    kubectl describe kafka
    kubectl describe controlcenter
    kubectl logs -f kafka-0
    kubectl logs -f -c controlcenter controlcenter-0
    kubectl exec -c controlcenter -it controlcenter-0 -- bash
    kubectl exec -it kafka-0 -- bash
