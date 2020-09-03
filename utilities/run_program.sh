#!/bin/bash

if [ -x "$(which $1)" ]
then
    eval "$@" 1>/dev/null 2>&1 & disown
else
    echo Cant find executable!
    exit 1
fi



