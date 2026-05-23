#!/bin/bash

set -ex

SQUID_USERNAME=${USERNAME:-proxynova}
SQUID_PASSWORD=${PASSWORD:-password}

## generate default password file regardless
htpasswd -cb /etc/squid/passwords "${SQUID_USERNAME}" "${SQUID_PASSWORD}"

# sed expects unix line endings
dos2unix /etc/squid/squid.conf

## if no username or password provided - disable auth check
if [[ -z "${USERNAME}" && -z "${PASSWORD}" ]]; then
  sed -i 's/^http_access allow authenticated$/http_access allow all/' /etc/squid/squid.conf
fi

## start in no daemon mode with debug level 1 going to stderr
/usr/sbin/squid -f /etc/squid/squid.conf -NYCd 1
