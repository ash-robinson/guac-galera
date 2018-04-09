#!/bin/bash

# Update first
apt-get update -y
apt-get upgrade -y

# install haproxy
apt-get install haproxy

# TODO:  Configure - copy template over /etc/haproxy/haproxy.cnf /
