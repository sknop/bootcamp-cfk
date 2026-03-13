#!/bin/bash

# Configuration
NAMESPACE="confluent"
CONF_FILE="/etc/dnsmasq.d/kind-k8s.conf"

echo "🔍 Scanning Kubernetes for LoadBalancers with external-dns annotations in namespace: $NAMESPACE..."

# Clear out the old configurations
cat /dev/null > "$CONF_FILE"

# Extract the hostname from the annotation and the IP from the load balancer status
kubectl get svc -n "$NAMESPACE" -o json | jq -r '
  .items[] |
  select(.spec.type == "LoadBalancer") |
  select(.status.loadBalancer.ingress[0].ip != null) |
  # Ensure annotations exist to prevent jq null reference errors
  select(.metadata.annotations != null) |
  # Grab only services that actually have the external-dns hostname defined
  select(.metadata.annotations["external-dns.alpha.kubernetes.io/hostname"] != null) |
  # Format it for dnsmasq: address=/hostname/IP
  "address=/\(.metadata.annotations["external-dns.alpha.kubernetes.io/hostname"])/\(.status.loadBalancer.ingress[0].ip)"
' >> "$CONF_FILE"

echo "✅ Wrote the following records to $CONF_FILE:"
cat "$CONF_FILE"

echo "🔄 Restarting dnsmasq to apply changes..."
sudo systemctl restart dnsmasq

echo "🎉 Done! Your annotated services are now resolvable."
