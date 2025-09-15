#!/bin/bash

appSetup() {
  # Set variables
  DOMAIN=${DOMAIN:-CONFLUENT}
  REALM=${REALM:-CONFLUENT.SVC.CLUSTER.LOCAL}
  ADMINPASS=${ADMINPASS:-Bootcamp4Ever}

  # Create smb.conf file
  samba-tool domain provision \
      --use-rfc2307 \
      --realm ${REALM} \
      --domain ${DOMAIN} \
      --dns-backend SAMBA_INTERNAL \
      --adminpass ${ADMINPASS}

  samba-tool domain passwordsettings set --complexity=off
  samba-tool domain passwordsettings set --history-length=0
  samba-tool domain passwordsettings set --min-pwd-age=0
  samba-tool domain passwordsettings set --max-pwd-age=0

  # Copy externally generated TLS files (we do not do internally self-signed here)
  # This assumes we mount a an external directory to /import/tls that contains the PEM files
  if [ -f /import/tls/ca.crt ] && [ -f /import/tls/tls.crt ] && [ -f /import/tls/tls.key ]; then
    cp /import/tls/* /var/lib/samba/private/tls
    chmod 600 /var/lib/samba/private/tls/*
  else
    ls -al /import/tls
    echo "Cert files ca.crt, tls.crt and/or tls.key are missing in tls directory. Stopping."
    exit 1
  fi
  # Ensure the CA is internally accessible for tools such as ldapadd
  cp /var/lib/samba/private/tls/ca.crt /usr/local/share/ca-certificates/ca.crt
  update-ca-certificates -f

  # Enable TLS for SMB

  sed -i '/.*idmap_ldb:use rfc2307 = yes/a\
          tls enabled  = yes\
          tls keyfile  = tls/tls.key\
          tls certfile = tls/tls.crt\
          tls cafile   = tls/ca.crt' /etc/samba/smb.conf
}

# Load Setup
appSetup

# Start Samba

samba --foreground --no-process-group