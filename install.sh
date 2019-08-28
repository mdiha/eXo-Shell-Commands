#!/bin/bash
mkdir -p ~/.exocmd/ &> /dev/null
cp -rf * ~/.exocmd/ &> /dev/null
rm -rf ~/.exocmd/install.sh &> /dev/null
export isAlr="$( cat ~/.bashrc | grep exocmd/custom.sh)"
if [[ $isAlr == "" ]]; then
echo "source ~/.exocmd/custom.sh" >> ~/.bashrc
fi
source ~/.exocmd/custom.sh
