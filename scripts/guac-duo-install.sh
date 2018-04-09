#!/bin/bash

# Version number of Guacamole to install
GUACVERSION="0.9.14"

# Update apt so we can search apt-cache for newest tomcat version supported
apt-get update

# Set SERVER to be the preferred download server from the Apache CDN
SERVER="http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${GUACVERSION}"

# Download Guacamole duo extension
wget -O guacamole-auth-duo-${GUACVERSION}.tar.gz ${SERVER}/binary/guacamole-auth-duo-${GUACVERSION}.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download guacamole-auth-duo-${GUACVERSION}.tar.gz"
    echo "${SERVER}/binary/guacamole-auth-duo-${GUACVERSION}.tar.gz"
    exit
fi

# Extract file
tar -xzf guacamole-auth-duo-${GUACVERSION}.tar.gz

# Make directories if required
if [ ! -d /etc/guacamole/extensions ] ; then
	mkdir -p /etc/guacamole/extensions

#Add to guacamole extensions
cp guacamole-auth-duo-${GUACVERSION}/guacamole-auth-duo-${GUACVERSION}.jar /etc/guacamole/extensions/

# Clean up
rm -rf guacamole-auth-duo-${GUACVERSION}

echo "guacamole duo extension installed successfully, configure guacamole.properties and restart the service"