#!/bin/env bash

shopt -s extglob

echo "{" > strudel.json
echo '"_base": "https://raw.githubusercontent.com/emptyflash/samples/main/",' >> strudel.json
LAST_DIRECTORY=""
for d in */; do
    echo "\"${d%\/}\": [" >> strudel.json
    for f in $d* ; do
        if [ ! -z $LAST_FILE ]; then
            echo "\"$LAST_FILE\"," >> strudel.json
        fi
        LAST_FILE="$f"
    done
    if [ ! -z $LAST_FILE ]; then
            echo "\"$LAST_FILE\"" >> strudel.json
    fi
    if [ ! -z $LAST_DIRECTORY ]; then
        echo "]," >> strudel.json
    fi
    LAST_DIRECTORY="$d"
done
if [ ! -z $LAST_DIRECTORY ]; then
    echo "]" >> strudel.json
fi
echo "}" >> strudel.json
