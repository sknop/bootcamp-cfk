# Deploy Samba
## Deploy cert-manager
## Create certificates

The secret samba-tls containing the appropriate certificate for samba has to exist.
If not available yet, create with 

    kubectl apply -f ../certificates.yaml

## Prepare LDIFs

    kubectl create configmap ldifs --from-file=ldifs/

Verify with

    kubectl get configmap ldifs
    kubectl describe configmap ldifs # for details

Install samba

    kubectl apply -f samba.yaml
