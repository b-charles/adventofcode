#!/bin/bash

cat input.txt | tee >/dev/null >(sed -E 's/^[a-z]*([0-9]).*/\10/') >(sed -E 's/^.*([0-9])[a-z]*/\1/') | paste -sd+ | bc

sed -E 's/one/o1e/g;s/two/t2o/g;s/three/t3e/g;s/four/f4r/g;s/five/f5e/g;s/six/s6x/g;s/seven/s7n/g;s/eight/e8t/g;s/nine/n9e/g' input.txt | tee >/dev/null >(sed -E 's/^[a-z]*([0-9]).*/\10/') >(sed -E 's/^.*([0-9])[a-z]*/\1/') | paste -sd+ | bc

