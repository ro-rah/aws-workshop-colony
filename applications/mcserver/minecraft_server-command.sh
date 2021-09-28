#!/bin/bash
echo 'Start Minecraft server'
cd /opt/minecraft
screen -dmS myserver /usr/bin/java -jar /opt/minecraft/server.jar --nogui