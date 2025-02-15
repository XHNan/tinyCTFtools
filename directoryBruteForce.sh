#!/bin/bash
# brute force files in a directory with only a "x" permission
while getopts w:d:x: flag
do
    case "${flag}" in
        w) wordlist=${OPTARG};;
        d) directory=${OPTARG};;
        x) extension=${OPTARG};;
    esac
done
if [ -z "$wordlist" ]  || [ -z $directory ] ; then
    echo "Usage: bash brute.sh -w <wordlist> -d <directory> "
    echo "Usage: bash brute.sh -w <wordlist> -d <directory> -x <extension>"
    echo "Example: bash brute.sh -w ./raft-small-words.txt -d /home -x sh,txt"
elif [[ ! -z "$extension" ]] ; then
    for i in $(cat $wordlist);do if [ -e $directory/$i ]; then echo "$i" exists; fi;done
    
    IFS=',' read -ra arr <<< "$extension"
    for singleextension in "${arr[@]}"; do
        for i in $(cat $wordlist);do if [ -e $directory/$i.$singleextension ]; then echo "$i.$singleextension" exists; fi;
        done
    done
else
    for i in $(cat $wordlist);do if [ -e $directory/$i ]; then echo "$i" exists; fi;done
fi
