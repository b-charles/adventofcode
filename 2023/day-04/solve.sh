#!/bin/bash

W=$(cat input.txt | sed -E "h;:l;s/(.*)\s+([0-9]+)\s+(\| .*)/\\\<\2\\\>\n\1 \3/M;tl;s/\n^.*\'//M;s/\n/\\\|/g;x;s/.*\| //;s/\s+/\n/g;s/.*/echo \"&\" \| grep -c \"/;G;s/.*/&\"/;s/\"\n/\"/ge")

echo "$W" | sed -E "s/.*/echo \"2^(&-1)\/1\" \| bc/e" | paste -sd+ | bc

# TODO PART 2


