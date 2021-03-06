#KDIR	:= /lib/modules/$(shell uname -r)/build
KDIR	:= /home/zbr/aWork/git/linux-2.6/linux-2.6.netchannels
PWD	:= $(shell pwd)
CC	:= gcc

CFLAGS	:= -I$(KDIR)/include -W -Wall -g -O3
LDFLAGS := -lc

ifdef NETCHANNEL
CFLAGS += -DKERNEL_NETCHANNEL
endif

ifdef DEBUG
CFLAGS += -DUDEBUG
endif

OBJS := atcp.o udp.o ip.o netchannel.o packet.o ncbuff.o stat.o
TARGETS	:= stack

all: $(OBJS) $(TARGETS)
	@echo "Compilation has been successfully finished."

stack: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@

atcp.o:		atcp.c sys.h Makefile
udp.o:		udp.c sys.h Makefile
ip.o:		ip.c sys.h Makefile
netchannel.o:	netchannel.c sys.h Makefile
ncbuff.o:	ncbuff.c sys.h Makefile
packet.o:	packet.c sys.h Makefile
stat.o:		stat.c stat.h sys.h Makefile

%.o:$(patsubst %.o,%.c,$<)
	$(CC) $(CFLAGS) $(patsubst %.o,%.c,$@) -c -o $@

clean:
	rm -f *.o *~ $(TARGETS) $(LIB_OBJS)

%: $(patsubst %,%.c,$<)
