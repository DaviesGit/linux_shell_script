#!/bin/bash

shopt -s extglob

main(){
    case ${1:0:2} in
        '-x')
        shift && extract_tar "$@" ;;
        '-t')
            list_depth=${1:2:1}  && shift
            [ -z "$list_depth" ] && list_depth=2
            list_tar "$list_depth" "$@"
        ;;
        *)
        echo Err: Unrecognized option! && exit 1;;
    esac
}

list_tar(){
    list_depth=$1 && shift
    exclude_string=''
    for i in $(seq 1 $list_depth)
    do
        exclude_string="$exclude_string""*/"
    done
    tar --exclude="$exclude_string*" -tvf "$@"
}

extract_tar () {
    default_parent_directory='/g/sb/'
    
    [ 0 -eq $# ] && echo Err: Must have one parameter! && exit 1
    file_name=$1 && shift
    
    target_directory=$1
    if [ ! -z $1 ]
    then
        [ "${1:0:1}" != "/" ] && target_directory="$default_parent_directory""$1"
    else
        target_directory=${file_name//@(.tar*|*\/)/}
    fi
    shift
    
    echo The target_directory is $target_directory
    
    [ -e "$target_directory" ] && [ ! -d "$target_directory" ] && \
    echo target_directory is not a directory && exit 1
    [ ! -e "$target_directory" ] && echo Making target_directory "$target_directory"  && \
    { mkdir "$target_directory" || exit 1 ; }
    
    tar -xvf "$file_name" -C "$target_directory"
}

main "$@"
