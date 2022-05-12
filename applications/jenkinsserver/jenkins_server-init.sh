#!/bin/bash
echo '=============== Staring init script for Jenkins Server ==============='
# References:
# https://www.redhat.com/sysadmin/install-jenkins-rhel8
# https://scriptcrunch.com/jenkins-installtion-guide/

# save all env for debugging
printenv > /var/log/colony-vars-"$(basename "$BASH_SOURCE" .sh)".txt

#accept updates
sudo yum -y update

#upgrade to python3
sudo yum -y install python36
sudo yum -y install epel-release

#set pip to use python3
sudo python3 -m pip install --upgrade --force pip

#install dependancies for python api
sudo python3 -m pip install Flask --user
sudo python3 -m pip install werkzeug --user

#install java
sudo yum -y install java-1.8.0-openjdk-devel

#install mariadb
#https://computingforgeeks.com/how-to-install-mariadb-on-amazon-linux-2/
sudo curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
sudo bash mariadb_repo_setup --os-type=rhel --os-version=7 --mariadb-server-version=10.6
sudo yum -y install MariaDB-server MariaDB-client


#install jenkins repo, key and software
#LTS as of this writing 2.303.2
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

#For sealight build
#install git
sudo yum -y install git
sudo yum -y install jq

sudo mkdir /opt/maven
cd /opt/maven
sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz
sudo tar xvf apache-maven-3.8.5-bin.tar.gz
sudo mv apache-maven-3.8.5  /usr/local/apache-maven
echo 'export M2_HOME=/usr/local/apache-maven' |  sudo tee /etc/profile.d/maven.sh
echo 'export M2=$M2_HOME/bin' |  sudo tee -a /etc/profile.d/maven.sh
echo 'export PATH=$M2:$PATH' |  sudo tee -a /etc/profile.d/maven.sh



#enable amazon epel and install demonize
sudo yum-config-manager --enable epel
sudo yum install daemonize -y
sudo yum -y install jenkins
echo '[Unit]' |  sudo tee /etc/systemd/system/jenkins.service.d/override.conf
echo 'Description=My Company Jenkins Controller' | sudo tee -a /etc/systemd/system/jenkins.service.d/override.conf
echo ' ' | sudo tee -a /etc/systemd/system/jenkins.service.d/override.conf
echo '[Service]' | sudo tee -a /etc/systemd/system/jenkins.service.d/override.conf
echo '# Add JVM configuration options' | sudo tee -a /etc/systemd/system/jenkins.service.d/override.conf
echo 'Environment="JAVA_OPTS=-Djava.awt.headless=true -XX:+UseStringDeduplication"'| sudo tee -a /etc/systemd/system/jenkins.service.d/override.conf