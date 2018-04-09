#!/bin/bash

# Update first
apt-get update -y
apt-get upgrade -y

# install ha-proxy
apt-get install haproxy

# TODO:  Configure - copy template over /etc/haproxy/haproxy.cnf /
