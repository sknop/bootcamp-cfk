https://docs.confluent.io/operator/current/co-manage-flink.html

helm upgrade --install confluent-operator confluentinc/confluent-for-kubernetes
helm upgrade --install cmf confluentinc/confluent-manager-for-apache-flink
