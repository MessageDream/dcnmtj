#!/bin/sh
usermod -u 1000 www-data && groupmod -g 1000 www-data

if [ "${DEBIAN_REPOSITORIES_REPLACE}" = "true" ]; then
  echo "---------- php replace source ----------"
  mv /etc/apt/sources.list /etc/apt/sources.list.bak
  mv /var/local/source/sources.list /etc/apt/sources.list
  rm -rf /var/local/source
fi

echo "---------- Install general dependencies ----------"
apt-get update && apt-get upgrade && apt-get install -y git cmake apt-utils openssl libssl-dev zip unzip libc-dev zlib1g-dev libz-dev libpq-dev libcurl4-openssl-dev

echo "---------- clean cache ----------"
apt-get clean
