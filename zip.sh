#!/bin/bash

function test_zip() {
    [[ ! -f "$1" ]] && echo "$1 does not exist or it is not a file!" && return 1
    unzip -t "$1" &>/dev/null || { echo "$1 is not a Zip archive or it is damaged" && return 2; }
}

function list_zip() {
    ZIP=$1
    test_zip "$ZIP" && \
    unzip -l "$ZIP" | awk '/[0-9]{4}(-[0-9]{2}){2}/ && !/\/$/ {print $NF}'
}

function base

function verify_zip_folder() {
    ZIP=$1
    FN=$(basename $ZIP)
    FN= 
    if [[ -z $2 ]]; then
        SUB=$FN
    SUB=$2
    TEMP_LIST=$(mktemp) && {
        list_zip_files "$ZIP" > $TEMP_LIST
        if [[ $(grep -c $SUB $TEMP_LIST) != $(wc -l $TEMP_LIST) ]]; then
            echo Warning: no all entries contains $SUB:
            grep -v  $SUB $TEMP_LIST
        fi
    }
}

#verify_zip_folder $1 $2


