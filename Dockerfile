FROM dovecot/dovecot:latest

COPY dovecot.conf /etc/dovecot/dovecot.conf
COPY dovecot-ldap.conf.ext /etc/dovecot/dovecot-ldap.conf.ext

CMD ["/usr/sbin/dovecot", "-F"]