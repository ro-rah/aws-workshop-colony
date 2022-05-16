#!/bin/bash
echo '=============== Staring script for Jenkins Server  ==============='
# save all env for debugging
printenv > /var/log/torque-vars-"$(basename "$BASH_SOURCE" .sh)".txt

#start PetClinic
sudo java -jar -Dserver.port=8081 spring-petclinic-2.6.0-SNAPSHOT.jar 