#!/bin/bash

flag=''
[ '-f' == $1 ] && flag='-f'" $flag" && shift
all_file="$@"
[ "$1" == '' ] && all_file="/a/configuration/map_file_path"


for file in "$all_file"
do
    #Get map file name
    while IFS= read -r line
    do
        eval `dirname $(readlink -f "$0")`/generate_map.sh $flag $line
    done < <( sed -e 's/#.*$//' -e '/^\s*$/d' $file )
done



