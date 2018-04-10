#!/bin/bash

# Update first
apt-get update -y
apt-get upgrade -y

# install haproxy
apt-get install haproxy