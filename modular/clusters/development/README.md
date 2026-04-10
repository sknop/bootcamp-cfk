# Installation for development on kind installations

If you need to install the software first, start [here](../../../setup/kind/install-software.sh).

Run [kind installation](../../../setup/kind/kind-setup.sh).

Then choose a deployment 

If you are using a LoadBalancer, you need to install after the deployment.

    kubectl apply -f metallb-config.yaml

## adjust /etc/hosts

You also need to adjust your `/etc/hosts` file to associate the hostnames with the exposed IP addresses 
published by the MetalLB load balancer.

## A better way: DNSMASQ

Rather than hardcoding the dns names and polluting the /etc/hosts file, it is better to use an additional
service that allows dynamic assignment of DNS names. This will keep /etc/hosts as it is and instead
overloads the resolver.

Run the script

    setup-dnsmasq.sh

This will configure dnsmasq that should already be installed if you 
used the [install-software.sh](../../../setup/kind/install-software.sh) script first.

Once configured, run 

    update-dns.sh

This will create the correct entries in a configuration file that dnsmasq will read.
You can now access the exposed services directly by name. 

Keep in mind that all services are mapped 
to port 80 (for HTTP) or port 443 (for HTTPS) except for the Kafka bootstrap servers, which will
continue to use the port 9092.



