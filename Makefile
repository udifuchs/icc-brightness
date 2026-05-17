# Copyright 2017 - 2019, Udi Fuchs
# SPDX-License-Identifier: MIT

PREFIX ?= /usr/local
BINDIR ?= ${PREFIX}/bin
AUTO_START_DIR=/etc/xdg/autostart

install:
	install -Dm644 -t $(DESTDIR)$(AUTO_START_DIR) icc-brightness.desktop

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/icc-brightness
	rm -f $(DESTDIR)$(AUTO_START_DIR)/icc-brightness.desktop