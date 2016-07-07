#!/bin/bash

arg=$*

rm -f *.o *.exe
make gen_defines.exe >& /dev/null
./gen_defines.exe $arg
rm -f fitsincache.o fitsincache.exe
make >& /dev/null
perf stat -e cycles -e instructions -e cache-references -e cache-misses -r 3 --log-fd 1 -- ./fitsincache.exe $arg
#./fitsincache.exe $arg
