#!/bin/bash
echo '=============== init script for mcadminconsole UI ==============='
# save all env for debugging
printenv > /var/log/torque-vars-"$(basename "$BASH_SOURCE" .sh)".txt

echo '=============== Get artifact and unzip  ==============='
echo '==> Extract artifact to /tmp/'
mkdir $ARTIFACTS_PATH/drop
unzip -o $ARTIFACTS_PATH/admin.zip -d /tmp/