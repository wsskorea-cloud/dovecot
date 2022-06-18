FROM dovecot/dovecot:latest

COPY dovecot.conf /etc/dovecot/dovecot.conf

COPY dovecot-ldap.conf.ext /etc/dovecot/dovecot-ldap.conf.ext

COPY run.sh /run.sh

ENTRYPOINT ["bash", "/run.sh"]

CMD ["tail", "-f", "/var/log/dovecot.log"]