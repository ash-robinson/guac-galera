#!/bin/bash

# Version number of Guacamole to install
# GUACVERSION="0.9.14"
GUACVERSION="1.0.0"

# Update apt so we can search apt-cache for newest tomcat version supported
apt-get update

# Get script arguments for non-interactive mode
while [ "$1" != "" ]; do
    case $1 in
        -m | --mysqlpwd )
            shift
            mysqlpwd="$1"
            ;;
		-u | --guacuser )
            shift
            guacpwd="$1"
            ;;
        -g | --guacpwd )
            shift
            guacpwd="$1"
            ;;
		-h | --host )
            shift
            host="$1"
            ;;
    esac
    shift
done

# Get MySQL root password and Guacamole User password
if [ -n "$mysqlpwd" ] && [ -n "$guacuser" ] && [ -n "$guacpwd" ] && [ -n "$host" ] ; then
        mysqlrootpassword=$mysqlpwd
		guacdbusername=$guacusername
        guacdbuserpassword=$guacpwd
		hostwithaccess=$host
else
    echo 
    while true
    do
        read -s -p "Enter a MySQL ROOT Password: " mysqlrootpassword
        echo
        read -s -p "Confirm MySQL ROOT Password: " password2
        echo
        [ "$mysqlrootpassword" = "$password2" ] && break
        echo "Passwords don't match. Please try again."
        echo
    done
	echo
    while true
    do
        read -s -p "Enter a Guacamole User Database Username: " guacdbusername
        echo
        read -s -p "Confirm Guacamole User Database Username: " password2
        echo
        [ "$guacdbusername" = "$password2" ] && break
        echo "Usernames don't match. Please try again."
        echo
    done
    echo
    while true
    do
        read -s -p "Enter a Guacamole User Database Password: " guacdbuserpassword
        echo
        read -s -p "Confirm Guacamole User Database Password: " password2
        echo
        [ "$guacdbuserpassword" = "$password2" ] && break
        echo "Passwords don't match. Please try again."
        echo
    done
	echo
    while true
    do
        read -s -p "Enter the host that can access the Database using this account: " hostwithaccess
        echo
        read -s -p "Confirm the host that can access the Database using this account: " password2
        echo
        [ "$hostwithaccess" = "$password2" ] && break
        echo "Hosts don't match. Please try again."
        echo
    done
    echo
fi

# Set SERVER to be the preferred download server from the Apache CDN
SERVER="http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${GUACVERSION}"

# Download Guacamole jdbc extension
wget -O guacamole-auth-jdbc-${GUACVERSION}.tar.gz ${SERVER}/binary/guacamole-auth-jdbc-${GUACVERSION}.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download guacamole-auth-jdbc-${GUACVERSION}.tar.gz"
    echo "${SERVER}/binary/guacamole-auth-jdbc-${GUACVERSION}.tar.gz"
    exit
fi

# Extract Guacamole files
tar -xzf guacamole-auth-jdbc-${GUACVERSION}.tar.gz

# SQL code
SQLCODE="
create database guacamole_db;
create user '$guacdbusername'@'$hostwithaccess' identified by \"$guacdbuserpassword\";
GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO '$guacdbusername'@'$hostwithaccess';
flush privileges;"

# Execute SQL code
echo $SQLCODE | mysql -u root -p$mysqlrootpassword

# Add Guacamole schema to newly created database
cat guacamole-auth-jdbc-${GUACVERSION}/mysql/schema/*.sql | mysql -u root -p $mysqlrootpassword guacamole_db

# Clean up
rm -rf guacamole-auth-jdbc-${GUACVERSION}

echo "guacamole database installed successfully, access configured for ${guacdbusername} from ${hostwithaccess}"
