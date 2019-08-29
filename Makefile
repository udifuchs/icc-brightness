# Copyright 2017 - 2019, Udi Fuchs
# SPDX-License-Identifier: MIT

CFLAGS := -Wall ${CFLAGS}
LDFLAGS := -l lcms2 ${LDFLAGS}

PREFIX ?= /usr/local
BINDIR ?= ${PREFIX}/bin
AUTO_START_PATH=/usr/share/gnome/autostart/

all: icc-brightness-gen

icc-brightness-gen: icc-brightness-gen.c

clean:
	rm -f icc-brightness-gen

install: all
	mkdir -p $(DESTDIR)$(BINDIR)
	install -m 755 icc-brightness-gen $(DESTDIR)$(BINDIR)
	install -m 755 icc-brightness $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(AUTO_START_PATH)
	install -m 644 icc-brightness.desktop $(DESTDIR)$(AUTO_START_PATH)
