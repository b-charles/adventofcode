#/bin/bash

rm -rf root; mkdir root
rm -rf sizes; mkdir sizes

# Generate files
(

cd root

while read -r line; do
  case "$line" in
    $\ cd\ /) ;;
    $\ cd\ ..) cd .. ;;
    $\ cd\ *[a-z.]) cd $(echo "$line" | cut -d " " -f 3) ;;
    $\ ls) ;;
    dir\ *[a-z.]) mkdir $(echo "$line" | cut -d " " -f 2) ;;
    *) cat /dev/urandom | head -c $(echo "$line" | cut -d " " -f 1) >$(echo "$line" | cut -d " " -f 2);;
  esac
done < ../input.txt

)

# Agregate files by directory
find root -mindepth 1 -type f -exec bash -c \
  'echo {} | sed -n ":l;s%/[^/]\+$%%;p;tl" | uniq | sed "s%/%_%g;s%^%of=sizes/%" | xargs -n 1 dd if={} bs=1G oflag=append conv=notrunc 2>/dev/null' \;

# Solve

echo "\033[0;35mPart 1:\033[0m $(find sizes -type f -size -100000c -printf "%s\n" | paste -sd+ | bc)"

echo "\033[0;35mPart 2:\033[0m $(find sizes -type f -size +$(($(ls -l sizes/root | cut -d " " -f 5) - 40000000))c -printf "%s\n" | awk '{if(min==""){min=$1}; if($1<min){min=$1}} END {print min}')"

