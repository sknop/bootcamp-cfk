## Preparation

The samba server has been containerized from the github repo https://github.com/sknop/bootcamp-samba.
This repo uploads the finished docker image to the DockerHub under the name sknop/bootcamp-samba.

If you want to rename that location, you also need to adjust the location in `samba.yaml`.

## Starting Samba

You need to create the required certificates first via tls/certificates.yaml.
This YAML file already has the required stanza for samba.

The store the ldif files in a config map so that samba can pick them up, for example

    kubectl create configmap ldifs --from-file=./ldifs

Then start up the samba server 

    kubectl apply -f samba.yaml

If you look at the `samba.yaml` file, you will see a `postStart` statement that simply pulls 
the ldif files mapped in from the configmap into the samba server via ldapadd.

