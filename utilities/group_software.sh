#!/bin/bash

# configuration
default_parent_directory='/g/s/'

[ 0 -eq $# ] && echo Err: Must ust have target_directory! && exit 1

target_directory=$1
[ "${1:0:1}" != "/" ] && target_directory="$default_parent_directory""$1"
shift
echo The target_directory is $target_directory

[ -e "$target_directory" ] && [ ! -d "$target_directory" ] && \
echo target_directory is not a directory && exit 1
[ ! -e "$target_directory" ] && echo making target_directory "$target_directory" && \
{ mkdir "$target_directory" || exit 1 ; }

for file in "$@"
do
    mv "$file" -t "$target_directory"
    echo The $file has been moved.
done

exit 0