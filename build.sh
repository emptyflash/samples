#!/bin/env bash

shopt -s extglob

echo "{" > strudel.json
echo '"_base": "https://raw.githubusercontent.com/emptyflash/samples/main/",' >> strudel.json

process_files() {
    LAST_FILE=""
    for f in $1* ; do
        if [ ! -z $LAST_FILE ]; then
            echo "\"$LAST_FILE\"," >> strudel.json
        fi
        LAST_FILE="$f"
    done
    if [ ! -z $LAST_FILE ]; then
        echo "\"$LAST_FILE\"" >> strudel.json
    fi
}

LAST_DIRECTORY=""
for d in */; do
    if [ ! -z $LAST_DIRECTORY ]; then
        echo "\"${LAST_DIRECTORY%\/}\": [" >> strudel.json
        process_files "$LAST_DIRECTORY"
        echo "]," >> strudel.json
    fi
    LAST_DIRECTORY="$d"
done
if [ ! -z $LAST_DIRECTORY ]; then
    echo "\"${LAST_DIRECTORY%\/}\": [" >> strudel.json
    process_files "$LAST_DIRECTORY"
    echo "]" >> strudel.json
fi
echo "}" >> strudel.json
