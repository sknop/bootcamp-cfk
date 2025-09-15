#!/usr/bin/env bash

while ! smbclient -L //samba -N > /dev/null 2>&1; do
    echo "Samba not responsive, retrying in 5 seconds..."
    sleep 5
done

set -e

for i in "$1"/*; do
  ldapadd -H ldaps://samba -D Administrator@CONFLUENT.SVC.CLUSTER.LOCAL -w Bootcamp4Ever -f "$i"
done

