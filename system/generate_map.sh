#!/bin/bash

prompt_error_and_exit(){
    echo $1
    echo Using -f to force map!
    exit 1
}

[ 0 -eq $# ] && prompt_error_and_exit 'Using for generate file map!'

flag='-s'
[ '-f' == $1 ] && flag='-f'" $flag" && shift


for file in "$@"
do
    maps=`sed -e 's/#.*$//' -e '/^\s*$/d' $file`
    #Execute shell command in the map file.
    while IFS= read -r line
    do
        eval $line
    done < <( echo "$maps" | sed -n '/^[^"'\'']/p' )
    #Create map.
    while IFS= read -r line
    do
        if eval [ ! -d $(echo $line | sed  's/^.* //') ]
        then
            eval ln $flag $line
        fi
    done < <( echo "$maps" | sed -n '/^["'\'']/p' )
done












