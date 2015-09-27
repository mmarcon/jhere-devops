#!/usr/bin/env bash

ansible-vault view "vaults/digital_ocean.yml" | egrep 'do_*' | while read -r line; do
    varname=`echo $line | cut -f 1 -d" " | awk '{print toupper($0)}'`
    varname="${varname//:}"
    varvalue=`echo $line | cut -f 2 -d" "`
    declare -x "$varname=$varvalue"
done
