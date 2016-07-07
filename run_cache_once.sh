#!/bin/bash

arg=$*

rm -f *.o *.exe
make gen_defines.exe >& /dev/null
./gen_defines.exe $arg
rm -f benchmark.o benchmark.exe
make >& /dev/null
perf stat -e cycles -e instructions -e cache-references -e cache-misses -r 3 --log-fd 1 -- ./benchmark.exe $arg
#./benchmark.exe $arg
