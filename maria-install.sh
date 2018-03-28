#!/bin/bash

# Update first
apt-get update -y
apt-get upgrade -y

# add mariadb/galera repo
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/10.1/ubuntu xenial main'

# resync
apt-get update -y

# install mariadb server
apt-get install mariadb-server rsync -y

#install mariadb
mysql_secure_installation