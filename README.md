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


<i>Enter current password for root (enter for none):  </i>
<i>Change the root password? [Y/n] n  </i>
<i>Remove anonymous users? [Y/n] Y  </i>
<i>Disallow root login remotely? [Y/n] Y  </i>
<i>Remove test database and access to it? [Y/n] Y  </i>
<i>Reload privilege tables now? [Y/n] Y  </i>

# guac-install
Script for installing Guacamole 0.9.14 on Ubuntu 16.04 or newer with MySQL. It should also work on pure Debian >= 7 but I have not tested.
The original scripts is here: https://github.com/MysticRyuujin/guac-install
This version was modified to remove the mysql install as for this purpose we used a base maria install.

Run script, enter MySQL Root Password and Guacamole User password. Guacamole User is used to connect to the Guacamole Database.

The script attempts to install tomcat8 if the available version is 8.5.x or newer, if tomcat8 is only 8.0.x it will fall back to tomcat7. If you want to manually specify a tomcat version there's a commented out line you can modify at line #73. Have at it.

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

Once installation is done you can access guacamole by browsing to: http://<host_or_ip>:8080/guacamole/
The default credentials are guacadmin as both username and password. Please change them or disable guacadmin after install!
