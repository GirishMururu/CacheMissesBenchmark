ifneq (DEBUG, "-g")
	DEBUG += "-O2"
endif

IDIR = ../include
CC = gcc
CPPFLAGS = -ggdb -Wall $(DEBUG) -I$(IDIR) -std=gnu11 -funroll-loops
LDFLAGS = -lpapi

EXEC = gen_defines.exe benchmark.exe

all: $(EXEC)

.PHONY: all 

$(EXEC): %.exe : %.o
		  $(CC) $< -o $@ $(CPPFLAGS) $(LDFLAGS)

$(OBJ): %.o : %.cpp defines.h
		  $(CC) -o $@ -c $< $(CPPFLAGS)

.PHONY: debug
debug: clean
		  $(MAKE) $(MAKEFILE) all DEBUG="-g"

.PHONY: clean
clean:
	rm -f *.o *.exe
