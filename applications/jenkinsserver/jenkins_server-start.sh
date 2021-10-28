#!/bin/bash
echo '=============== Staring script for Jenkins Server  ==============='
# save all env for debugging
printenv > /var/log/torque-vars-"$(basename "$BASH_SOURCE" .sh)".txt

#start Jenkins
sudo chkconfig jenkins on
sudo systemctl start jenkins