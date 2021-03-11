#!/bin/bash
if [ $# -eq 0 ]; then
    echo "No list of hostnames was specified."
    exit 1
fi

count=$(($(wc -l < $1)))
blocked=0
current=0

sleep .5
echo "The script will query a total of $count hostnames."
sleep 1

while IFS= read -r line; do
  host $line | grep "49.205.171.200" > /dev/null && let "blocked=blocked+1"
  let "current=current+1"
  echo -ne "[TOTAL]: $count [CURRENT]: $current [BLOCKED]: $blocked"\\r
done < "$1"
echo "[TOTAL]: $count [CURRENT]: $current [BLOCKED]: $blocked";
echo "$blocked out of the $count hostnames in the provided list appear to be blocked."
