#!/bin/bash
INPUT=$1
MASSDNS="/usr/local/bin/massdns"

if [[ "$INPUT" && -x "$MASSDNS" ]] ; then
    massdns -r resources/resolver.txt -s 5000 $INPUT > output.txt
fi
