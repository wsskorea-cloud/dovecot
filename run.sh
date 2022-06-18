#!/bin/bash

if [ $LDAP_URIS = "" ]; then
  echo "Please enter 'LDAP_URIS' environment variable."
  exit 1
else
  sed -i --expression "s@LDAP_URIS@$LDAP_URIS@g" /etc/dovecot/dovecot-ldap.conf.ext
fi

if [ $LDAP_DN = "" ]; then
  echo "Please enter 'LDAP_DN' environment variable."
  exit 1
else
  sed -i --expression "s@LDAP_DN@$LDAP_DN@g" /etc/dovecot/dovecot-ldap.conf.ext
fi

if [[ $LDAP_PASSWORD = "" ]]; then
  echo "Please enter 'LDAP_PASSWORD' environment variable."
  exit 1
else
  sed -i --expression "s/LDAP_PASSWORD/$LDAP_PASSWORD/g" /etc/dovecot/dovecot-ldap.conf.ext
fi

if [[ $LDAP_BASE = "" ]]; then
  echo "Please enter 'LDAP_BASE' environment variable."
  exit 1
else
  sed -i --expression "s/LDAP_BASE/$LDAP_BASE/g" /etc/dovecot/dovecot-ldap.conf.ext
fi

if [[ $TLS = "yes" ]]; then
  TLS=$TLS
else
  TLS="no"
fi
sed -i --expression "s@TLS@$TLS@g" /etc/dovecot/dovecot.conf

if [[ $TLS = "yes" && $TLS_CERT = "" ]]; then
  echo "Please enter 'TLS_CERT' environment variable when you use 'TLS=yes'."
  exit 1
else
  sed -i --expression "s@#ssl_cert = <TLS_CERT@ssl_cert = <$TLS_CERT@g" /etc/dovecot/dovecot.conf
fi

if [[ $TLS = "yes" && $TLS_KEY = "" ]]; then
  echo "Please enter 'TLS_KEY' environment variable when you use 'TLS=yes'."
  exit 1
else
  sed -i --expression "s@#ssl_key = <TLS_KEY@ssl_key = <$TLS_KEY@g" /etc/dovecot/dovecot.conf
fi

/usr/sbin/dovecot -F

tail -f /var/log/dovecot.log
