#!/bin/bash
echo '=============== Staring init script for Promotions Manager UI ==============='

# save all env for debugging
printenv > /var/log/colony-vars-"$(basename "$BASH_SOURCE" .sh)".txt

echo '==> Download Minecraft server version 1.16.2'
yum update
yum install curl -y
curl https://launcher.mojang.com/v1/objects/c5f6fb23c3876461d46ec380421e42b289789530/server.jar --output server.jar

echo -e '#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
\n#Wed Aug 25 02:30:24 UTC 2021 \neula=true' > eula.txt

echo "==> Updating gamemode, current value is $GAMEMODE"
if [ "$GAMEMODE" == "creative" ]; then
    sed 's/gamemode=survival/gamemode=creative/' server.properties
elif [ "$GAMEMODE" == "survival" ]; then
    echo "Nothing to do here."
elif [ "$GAMEMODE" == "adventure" ]; then
    sed 's/gamemode=survival/gamemode=adventure/' server.properties
elif [ "$GAMEMODE" == "spectator" ]; then
    sed 's/gamemode=survival/gamemode=spectator/' server.properties
else
	echo "You must state one of the following gamemodes: creative, survival, adventure, or spectator"
fi

echo "==> Updating allow-flight current value is $ALLOWFLIGHT"
if [ "$ALLOWFLIGHT" == "true" ]; then
    sed 's/allow-flight=false/allow-flight=true/' server.properties
elif [ "$ALLOWFLIGHT" == "false" ]; then
    sed 's/allow-flight=false/allow-flight=false/' server.properties
else
	echo "Value for ALLOWFLIGHT must be true or false"
fi
