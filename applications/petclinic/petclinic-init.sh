#!/bin/bash
echo '=============== Staring init script for PetClinic Server ==============='

# save all env for debugging
printenv > /var/log/colony-vars-"$(basename "$BASH_SOURCE" .sh)".txt

#install java
sudo yum -y install java-11-openjdk-devel


#install git
sudo yum -y install git

#Install JFrog CLI
sudo echo "[jfrog-cli]" > jfrog-cli.repo;
sudo echo "name=jfrog-cli" >> jfrog-cli.repo;
sudo echo "baseurl=https://releases.jfrog.io/artifactory/jfrog-rpms" >> jfrog-cli.repo;
sudo echo "enabled=1" >> jfrog-cli.repo;
sudo rpm --import https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key
sudo mv jfrog-cli.repo /etc/yum.repos.d/;
sudo yum install -y jfrog-cli-v2-jf;

#import creds
jf config import $JFROGTOKEN


#download artifact
jf rt dl --flat default-generic-local/com/petclinic/spring-petclinic-$PETCLINICVERSION.jar

#start PetClinic
sudo nohup java -jar spring-petclinic-2.6.0-SNAPSHOT.jar &