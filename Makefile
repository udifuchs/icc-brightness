# Copyright 2017 - 2019, Udi Fuchs
# SPDX-License-Identifier: MIT

CFLAGS := -Wall ${CFLAGS}
LDFLAGS := -l lcms2 ${LDFLAGS}

PREFIX ?= /usr/local
BINDIR ?= ${PREFIX}/bin
AUTO_START_DIR=/etc/xdg/autostart

all: icc-brightness-gen

icc-brightness-gen: icc-brightness-gen.c

clean:
	rm -f icc-brightness-gen

install: all
	install -Dm755 -t $(DESTDIR)$(BINDIR) icc-brightness icc-brightness-gen
	install -Dm644 -t $(DESTDIR)$(AUTO_START_DIR) icc-brightness.desktop
