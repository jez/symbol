prefix := /usr/local
bindir := $(prefix)/bin
sharedir := $(prefix)/share/symbol

install:
	mkdir -p $(bindir) $(sharedir)
	install symbol-new $(bindir)
	cp -rv scaffold $(sharedir)

clean:
	rm -rf bin share
