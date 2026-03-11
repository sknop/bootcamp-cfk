# Installation for development on kind installations

If you need to install the software first, start [here](../../../setup/kind/install-software.sh).

Run [kind installation](../../../setup/kind/kind-setup.sh).

Then choose a deployment 

If you are using a LoadBalancer, you need to install after the deployment.

    kubectl apply -f metallb-config.yaml

You also need to adjust your `/etc/hosts` file:

