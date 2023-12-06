#!/bin/bash

F='s/([0-9]+) ([0-9]+)/(\1.0 + sqrt(\1.0*\1.0 - 4.0*\2.0))\/2 - (\1.0 - sqrt(\1.0*\1.0 - 4*\2.0))\/2/'

cat input.txt \
  | sed -nE 's/Time:/\n/;h;n;s/Distance://;H;x;:l;s/\`(.*)\n\s*([0-9]+)(.*)\n\s*([0-9]+)(.*)\'"'"'/\1\n>\2 \4\n\3\n\5/;tl;s/>//g;s/\n+/\n/g;p' \
  | sed -E "$F" | bc | paste '-sd*' | bc

cat input.txt | sed -nE 's/Time:/\n/;s/ //g;h;n;s/Distance://;s/ //g;H;x;s/([0-9]+)\n([0-9]+)/\1 \2/;p' | sed -E "$F" | bc

