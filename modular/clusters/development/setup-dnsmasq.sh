#!/bin/bash

# Create the dnsmasq config file
sudo bash -c 'cat > /etc/dnsmasq.d/00-local-only.conf <<EOF
# Listen only on this specific internal IP
listen-address=127.0.0.2
bind-interfaces

# Do not read /etc/resolv.conf (we only care about our .kind records)
no-resolv
local=/bootcamp.confluent.io/
EOF'

# Restart dnsmasq

sudo systemctl restart dnsmasq

# Ensure directory exists

sudo mkdir -p /etc/systemd/resolved.conf.d/

sudo bash -c 'cat > /etc/systemd/resolved.conf.d/bootcamp.conf <<EOF
[Resolve]
DNS=127.0.0.2
# The tilde (~) means "Route queries for this domain strictly to the DNS above"
Domains=~bootcamp.confluent.io
EOF'

# Restart systemd-resolved
sudo systemctl restart systemd-resolved

# Create (empty) DNS config file with correct permissions

sudo touch /etc/dnsmasq.d/kind-k8s.conf
sudo chown ubuntu:ubuntu /etc/dnsmasq.d/kind-k8s.conf
