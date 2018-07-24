#!/bin/bash

### Usage: ./list_inodes.sh DESIRED_DIRECTORY ###

cd $1
#pwd 
echo "### Total em $(pwd) ###"
ls -p | grep -v / | wc -l ;

if [ "$(pwd)" = "/" ]; then
        for A in $(ls -d */); do
                echo "### $A ###" ;
                find $(pwd) -iname "*" -print | grep ^/$A | sort | uniq -c | awk '{sum += $1} END {print sum}';
        done;
else
        for A in $(ls -d */); do
                echo "### $A ###" ;
                find $(pwd) -iname "*" -print | grep ^$(pwd)/$A | sort | uniq -c | awk '{sum += $1} END {print sum}';
        done;
fi
