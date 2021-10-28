#!/bin/bash
echo '=============== Staring init script for Jenkins Server ==============='
# References:
# https://www.redhat.com/sysadmin/install-jenkins-rhel8
# https://scriptcrunch.com/jenkins-installtion-guide/

# save all env for debugging
printenv > /var/log/colony-vars-"$(basename "$BASH_SOURCE" .sh)".txt

#accept updates
sudo yum -y update

#install open-jdk
sudo yum -y install java-1.8.0-openjdk-devel

#install wget
sudo yum -y install wget

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

#install jenkins repo, key and software
#LTS as of this writing 2.303.2
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
#sudo yum -y install jenkins