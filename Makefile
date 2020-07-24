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

uninstall:
	rm -f $(DESTDIR)$(BIN_PATH)icc-brightness-gen
	rm -f $(DESTDIR)$(BIN_PATH)icc-brightness
	rm -f $(DESTDIR)$(AUTO_START_PATH)icc-brightness.desktop

local-install: BIN_PATH=~/.local/bin/
local-install: AUTO_START_PATH=~/.config/autostart/
local-install: install

local-uninstall: BIN_PATH=~/.local/bin/
local-uninstall: AUTO_START_PATH=~/.config/autostart/
local-uninstall: uninstall

