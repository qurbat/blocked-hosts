#!/bin/bash
INPUT=$1
MASSDNS="/usr/local/bin/massdns"
BLOCKEDHOST="202.83.21.14"

if test -f output.txt; then
	echo "[-] working with output.txt" &&
	cat output.txt | grep $BLOCKEDHOST > results.txt &&
	echo "[+] total number of blocked hosts (non de-duplicated): " && cat results.txt | wc -l &&
	echo "[-] sorting and de-duplicating results.txt"
	sed -i 's/. 0 IN A '"$BLOCKEDHOST"'//g' results.txt &&
	python apex.py results.txt > temp_results.txt && cat temp_results.txt | sort | uniq > sorted_results.txt && 
	echo "[+] total number of unique domains: " && cat sorted_results.txt | wc -l
	exit 0
fi


if [[ "$INPUT" && -x "$MASSDNS" ]] ; then
    massdns -r resources/resolver.txt -s 10000 $INPUT > output.txt &&
	echo "[-] working with output.txt" &&
	cat output.txt | grep $BLOCKEDHOST > results.txt &&
	echo "[+] total number of blocked hosts (non de-duplicated): " && cat results.txt | wc -l &&
	echo "[-] sorting and de-duplicating results.txt"
	sed -i 's/. 0 IN A '"$BLOCKEDHOST"'//g' results.txt &&
	python apex.py results.txt > temp_results.txt && cat temp_results.txt | sort | uniq > sorted_results.txt && 
	sleep 1
	echo "[+] total number of unique domains: " && cat sorted_results.txt | wc -l
	exit 0
fi
