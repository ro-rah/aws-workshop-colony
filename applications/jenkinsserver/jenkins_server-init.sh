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

#set pip to use python3
sudo python3 -m pip install --upgrade --force pip

#install dependancies for python api
sudo python3 -m pip install Flask --user
sudo python3 -m pip install werkzeug --user


#install open-jdk
sudo yum -y install java-1.8.0-openjdk-devel

#install wget
sudo yum -y install wget

#install jenkins repo, key and software
#LTS as of this writing 2.303.2
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum -y install jenkins
sudo yum -y remove java-1.7.0-openjdk.x86_64

#For sealight build
#install git
sudo yum -y install git
sudo yum -y install jq
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven

#enable amazon epel and install demonize
sudo yum -y install epel-release
sudo yum-config-manager --enable epel
sudo yum install daemonize -y

