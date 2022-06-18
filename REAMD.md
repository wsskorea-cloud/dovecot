# Dovecot with LDAP

## Introduction

This docker image is an MDA(Mail Delivery Agent) server using [Dovecot](https://www.dovecot.org/])
and [LDAP](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol).

## How to use

### Build image

Please use this [Dockerfile](Dockerfile) to build docker image.

```shell
docker build -t dovecot-ldap:latest
```

### Run image without TLS

```shell
docker run -itd \
    -p 24:24 \
    -p 110:110 \
    -p 143:143 \
    -e LDAP_URIS="ldap://ldap.wsskorea.cloud" \
    -e LDAP_DN="cn=admin,dc=wsskorea,dc=cloud" \
    -e LDAP_PASS="admin12345!@" \
    -e LDAP_BASE="dc=wsskorea,dc=cloud" \
    --name dovecot-ldap \
    dovecot-ldap:latest
```

### Run image with TLS

```shell
docker run -itd \
    -p 24:24 \
    -p 993:993 \
    -p 995:995 \
    -e LDAP_URIS="ldap://ldap.wsskorea.cloud" \
    -e LDAP_DN="cn=admin,dc=wsskorea,dc=cloud" \
    -e LDAP_PASS="admin12345!@" \
    -e LDAP_BASE="dc=wsskorea,dc=cloud" \
    -e TLS="yes" \
    -e TLS_CERT="/tls/cert.pem" \
    -e TLS_KEY="/tls/key.pem" \
    -v /tls/:/tls/ \
    --name dovecot-ldap \
    dovecot-ldap:latest
```

## Environment Variables

### `LDAP_URIS`

This variable is LDAP server's uri like `ldap://ldap.wsskorea.cloud`. If you want to use TLS, please use `ldaps://`.

### `LDAP_DN`

This variable is LDAP server's DN(Distinguished Name) which can access all resources in LDAP server. You can understand
DN as an admin account.

### `LDAP_PASS`

This variable is DN's password.

### `LDAP_BASE`

This variable is a base directory where you can find the users.

### `TLS`

This variable is an option to use TLS encryption. If you enter `yes`, you should enter `TLS_CERT` and `TLS_KEY` too.
Default is `no`.

### `TLS_CERT`

This variable is the TLS certification file location.

### `TLS_KEY`

This variable is the TLS key file location.

## Log

You can get log at `/var/log/dovecot.log`.

## License

MIT License

Copyright (c) 2022-2022 WorldSkills Korea Cloud Computing

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.