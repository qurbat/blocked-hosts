#!/bin/bash
line_count=$(wc -l < compiled_block_list.txt)
line_count=$(echo $line_count | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')

badge_ct="[![Statistics](https://img.shields.io/badge/sites-$line_count-brightgreen)](https://github.com/qurbat/blocked-hosts)"

sed -i '2d' README.md
sed -i "2i $badge_ct" README.md