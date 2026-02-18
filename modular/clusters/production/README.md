# Production environments

Production environments require a full Confluent license.

Install this license requires two steps.

First, remove to automatically generated secret

    kubectl delete secret confluent-operator-licensing
    
Then install your new license file. It is a text file in form of a JWT token:

    kubectl create secret generic confluent-operator-licensing --from-file=license.txt=license.txt

The production kustomization script adds a globalLicense component that simply instructs each component to look
for the global license in the above secret.

## ⚠️ Failure to deploy the license first before starting up the cluster will lead to a failed deployment. ⚠️

