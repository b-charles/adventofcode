#!/bin/bash

MAX=$(paste '-d ' \
  <(cat input.txt | sed -E ":l;s/(.*)^(.*) ([0-9]+) red(.*)\'/\1\3\n\2 \4/M;tl;s/\n.*\'//M;s/.*/echo \"&\" | sort -nr | head -1/;e") \
  <(cat input.txt | sed -E ":l;s/(.*)^(.*) ([0-9]+) green(.*)\'/\1\3\n\2 \4/M;tl;s/\n.*\'//M;s/.*/echo \"&\" | sort -nr | head -1/;e") \
  <(cat input.txt | sed -E ":l;s/(.*)^(.*) ([0-9]+) blue(.*)\'/\1\3\n\2 \4/M;tl;s/\n.*\'//M;s/.*/echo \"&\" | sort -nr | head -1/;e") )

echo "$MAX" | sed -E 's/([0-9]+) ([0-9]+) ([0-9]+)/\1<=12 \&\& \2<=13 \&\& \3<=14/' | bc | sed -n '/1/=' | paste -sd+ | bc

echo "$MAX" | sed -E 's/ /*/g' | paste -sd+ | bc

