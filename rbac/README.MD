To run this setup, you will need to:

Deploy the certificates from modular/assets/tls
Deploy ldifs and samba from modular/assets/samba
Deploy the mds key from modular/assets/mds

Then deploy the bearer token in a secret

    kubectl create secret generic rest-credential --from-file=bearer.txt=bearer.txt

Now you are ready to deploy the whole cluster

    kubectl apply -f confluent-platform-c3++.yaml

