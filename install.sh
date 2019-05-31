#!/bin/bash
rm -rf ~/.exocmd/* &> /dev/null
mkdir -p ~/.exocmd/ &> /dev/null
cp -rf * ~/.exocmd/ &> /dev/null
rm -rf ~/.exocmd/install.sh &> /dev/null
export isAlr="$( cat ~/.bashrc | grep exocmd/custom.sh)"
if [[ $isAlr == "" ]]; then
echo "source ~/.exocmd/custom.sh" >> ~/.bashrc
source ~/.exocmd/custom.sh
fi

cp inject-spaces.sh ~/.exocmd &> /dev/null
cp inject-users.sh ~/.exocmd &> /dev/null


