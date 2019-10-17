#!/bin/bash
mkdir -p ~/.exocmd/ &> /dev/null
wkdir="$1"
if [ -z "$wkdir" ]; then wkdir="$(pwd)" ; fi
cp -rf "$wkdir"/* ~/.exocmd/ &> /dev/null
if [ -z "$( cat ~/.bashrc | grep exocmd/custom.sh)" ]; then
echo "source ~/.exocmd/custom.sh" >> ~/.bashrc
fi
source ~/.exocmd/custom.sh
