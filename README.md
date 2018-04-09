# Scripts	
Below are an assortment of scripts to help with the installation of a Guacamole instance with a Maria DB backend.

# maria-install
Script for installing Maria DB 10.1 on Ubuntu 16.04 or newer, based off of the tutorial at:  https://www.howtoforge.com/tutorial/how-to-install-and-configure-galera-cluster-on-ubuntu-1604/

Run script to install a secure Maria DB installation locally, ready for clustering.

## How to Run:

### Make Executable

<code>chmod +x maria-install.sh</code>

### Run it as root:

<code>./maria-install.sh</code>

In this process, you will be asked to set root password, remove anonymous users, disallow root login remotely and remove test database. Answer all the questions as shown below for default behaviour:


<i>Enter current password for root (enter for none):  </i></br>
<i>Change the root password? [Y/n] n  </i></br>
<i>Remove anonymous users? [Y/n] Y  </i></br>
<i>Disallow root login remotely? [Y/n] Y  </i></br>
<i>Remove test database and access to it? [Y/n] Y  </i></br>
<i>Reload privilege tables now? [Y/n] Y  </i></br>

# guac-db-install
Script for creating a Guacamole Database for Maria DB, alongside a user with appropriate permissions to be used by Guacamole.

If running the script on a Galera cluster, run the script on one node to create the guacamole database across the cluster.

## How to Run:

### Make Executable

<code>chmod +x guac-db-install.sh</code>

### Run it as root:

<code>./guac-db-install.sh</code>

You can choose to run in interactive mode where you should enter the MySQL Root Password, Guacamole Username and User Password and the host you wish the account to have access from, or specify the parameters inline as shown below.

### Run non-interactive

<code>./guac-db-install.sh -m \<mysqlpassword> -u \<guacuser> -p \<guacpass> -h \<host> </code>

# guac-install
Script for installing Guacamole 0.9.14 on Ubuntu 16.04 or newer with MySQL. It should also work on pure Debian >= 7 but I have not tested.
The original scripts is here: https://github.com/MysticRyuujin/guac-install
This version was modified to remove the mysql install as for this purpose we used a base maria install.

Run script, enter MySQL Root Password and Guacamole User password. Guacamole User is used to connect to the Guacamole Database.

The script attempts to install tomcat8 if the available version is 8.5.x or newer, if tomcat8 is only 8.0.x it will fall back to tomcat7. If you want to manually specify a tomcat version there's a commented out line you can modify at line #73. Have at it.

This script will install to a local maria db, if you wish to connect to an external cluster modify the guacamole.properties file.

## How to Run:

### Make it executable:

<code>chmod +x guac-install.sh</code>

### Run it as root:

Interactive (asks for passwords):

<code>./guac-install.sh</code>

Non-Interactive (passwords provided via cli):

<code>./guac-install.sh --mysqlpwd password --guacpwd password</code>

OR

<code>./guac-install.sh -m password -g password</code>

Once installation is done you can access guacamole by browsing to: http://\<host_or_ip>:8080/guacamole/
The default credentials are guacadmin as both username and password. Please change them or disable guacadmin after install!

# guac-duo-install
Script for installing the Apache Duo authentication module for guacamole.

Requires an Apache Duo account, which you can sign up for here: https://signup.duo.com/

To configure, add the following lines to your guacamole.properties file:

<i>	duo-api-hostname: \<duo hostname> </i></br>
<i>	duo-integration-key:  \<duo integration key> </i></br>
<i>	duo-secret-key: \<duo secret key> </i></br>

## How to Run:

### Make Executable

<code>chmod +x guac-duo-install.sh</code>

### Run it as root:

<code>./guac-duo-install.sh</code>

# haproxy-install
Script for installing haproxy on Ubuntu 16.04 or newer, simple but included for completeness

Run script to install haproxy on the current box.

## How to Run:

### Make Executable

<code>chmod +x haproxy-install.sh</code>

### Run it as root:

<code>./haproxy-install.sh</code>


