all::

DOXYGEN = doxygen

CFLAGS = -g -O2

BASIC_CFLAGS := -Isrc
BASIC_CFLAGS += -DGIT__PRIVATE
BASIC_CFLAGS += -fvisibility=hidden

OBJS = $(patsubst %.c,%.o,$(wildcard src/*.c))
HDRS = $(wildcard src/*.h)


all:: libgit2.a

clean:
	rm -f libgit2.a src/*.o
	rm -rf apidocs

apidocs:
	$(DOXYGEN) api.doxygen
	cp CONVENTIONS apidocs/

.c.o:
	$(CC) $(BASIC_CFLAGS) $(CFLAGS) -c $< -o $@

$(OBJS): $(HDRS)
libgit2.a: $(OBJS)
	rm -f libgit2.a
	$(AR) cr libgit2.a $(OBJS)

.PHONY: all
.PHONY: clean
.PHONY: apidocs