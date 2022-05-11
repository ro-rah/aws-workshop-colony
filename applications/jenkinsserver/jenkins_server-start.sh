#!/bin/bash
echo '=============== Staring script for Jenkins Server  ==============='
# save all env for debugging
printenv > /var/log/torque-vars-"$(basename "$BASH_SOURCE" .sh)".txt

#start Jenkins
sudo systemctl enable jenkins.service
#systemctl won't work on this version of linux
#sudo systemctl start jenkins
sudo sudo systemctl start jenkins