#!/bin/bash
for file in "$@"
do
    #Build alias
    while IFS= read -r line
    do
        PATH="$line:$PATH"
    done < <( sed -e 's/#.*$//' -e '/^\s*$/d' -e 's/^[ \t]*//;s/[ \t]*$//' $file )
done