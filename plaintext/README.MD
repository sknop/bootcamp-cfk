# PLAINTEXT example

## Start here if you never deployed Confluent in Kubernetes before 

Deploy the cluster

    kubectl apply -f confluent-platform-c3++.yaml

Verify the cluster is up and running, I tend to use 

    watch kubectl get pods

Use Ctrl-C to end the watch once everything is deployed and running.

To see the Control-Center, use port-forwarding

    kubectl port-forward --address 0.0.0.0 controlcenter-0 9021:9021

The address 0.0.0.0 is useful if you running your Kubernetes cluster on a separate host machine.

To test a client, you can use this chart:

    kubectl apply -f producer.yaml
    kubectl exec -it kafka-client-0 -- bash

Inside the pod, you can use, for example

    kafka-topics --list --bootstrap-server kafka:9092
    kafka-topics --list --bootstrap-server kafka.confluent.svc.cluster.local:9092

Cleanup

    kubectl delete -f producer.yaml
    kubectl delete -f confluent-platform-c3++.yaml

Debugging hints

    kubectl describe kafka
    kubectl describe controlcenter
    kubectl logs -f kafka-0
    kubectl logs -f -c controlcenter controlcenter-0
    kubectl exec -c controlcenter -it controlcenter-0 -- bash
    kubectl exec -it kafka-0 -- bash
