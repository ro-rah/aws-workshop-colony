#!/bin/bash
echo '=============== Staring script for Jenkins Server  ==============='
# save all env for debugging
printenv > /var/log/torque-vars-"$(basename "$BASH_SOURCE" .sh)".txt

sudo yum -y remove java-1.7.0-openjdk.x86_64

#start Jenkins
sudo chkconfig jenkins on
#systemctl won't work on this version of linux
#sudo systemctl start jenkins
sudo service jenkins start