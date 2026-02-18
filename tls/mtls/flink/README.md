https://docs.confluent.io/operator/current/co-manage-flink.html

helm upgrade --install cp-flink-kubernetes-operator confluentinc/flink-kubernetes-operator
helm upgrade --install cmf confluentinc/confluent-manager-for-apache-flink
