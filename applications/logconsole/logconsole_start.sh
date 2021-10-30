#!/bin/bash
echo '=============== Staring script for mcadminconsole UI ==============='
# save all env for debugging
printenv > /var/log/torque-vars-"$(basename "$BASH_SOURCE" .sh)".txt
cd /tmp
python3 mcadmin.py