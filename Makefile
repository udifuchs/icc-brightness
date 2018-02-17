BIN_PATH=/usr/local/bin/
AUTO_START_PATH=/usr/share/gnome/autostart/
all: icc-brightness-gen

icc-brightness-gen: icc-brightness-gen.c
	gcc -W -Wall icc-brightness-gen.c -l lcms2 -o $@

clean:
	rm icc-brightness-gen

install:
	cp icc-brightness-gen ${BIN_PATH}
	cp icc-brightness ${BIN_PATH}
	cp icc-brightness.desktop ${AUTO_START_PATH}
