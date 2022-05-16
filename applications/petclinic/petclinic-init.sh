#!/bin/bash
echo '=============== Staring init script for PetClinic Server ==============='

# save all env for debugging
printenv > /var/log/colony-vars-"$(basename "$BASH_SOURCE" .sh)".txt

#accept updates
sudo yum -y update

#upgrade to python3
sudo yum -y install python36
sudo yum -y install epel-release
sudo yum -y install wget

#set pip to use python3
sudo python3 -m pip install --upgrade --force pip

#install dependancies for python api
sudo python3 -m pip install Flask --user
sudo python3 -m pip install werkzeug --user

#install java
sudo yum -y install java-11-openjdk-devel


#install git
sudo yum -y install git

#download artifact
curl -H "X-JFrog-Art-Api:AKCp8mYoYy1TSaXeuWZRuQu7DpnTEE4fmjmxzhXvW47rwBoGnWGfFTH8B5jMSxrLPTEtnpcaY" -O "https://ronak.jfrog.io/artifactory/default-generic-local/com/petclinic/spring-petclinic-2.6.0-SNAPSHOT.jar"