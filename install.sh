#!/bin/bash
# eXo Basic Shell Commands
# Released by Houssem B. Ali - eXo Support LAB 2019
# eXo-Shell-Commands First Installer
# + You can use it for manually update

mkdir -p ~/.exocmd/ &> /dev/null
wkdir="$1"
if [ -z "$wkdir" ]; then wkdir="$(pwd)" ; fi
cp -rf "$wkdir"/* ~/.exocmd/ &> /dev/null
if [ -z "$( cat ~/.bashrc | grep exocmd/custom.sh)" ]; then
echo "source ~/.exocmd/custom.sh" >> ~/.bashrc
fi
source ~/.exocmd/custom.sh
