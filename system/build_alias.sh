#!/bin/bash
for file in "$@"
do
    #Build alias
    while IFS= read -r line
    do
        eval alias $line
    done < <( sed -e 's/#.*$//' -e '/^\s*$/d' $file )
done












