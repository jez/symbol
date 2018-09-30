prefix := $(HOME)/.local
bindir := $(prefix)/bin
sharedir := $(prefix)/share/symbol

default:
	@echo "usage:"
	@echo "  make install [prefix=<prefix>]"
	@echo "  make lint"

install:
	mkdir -p $(bindir) $(sharedir)
	install symbol-new $(bindir)
	cp -rv scaffold $(sharedir)

lint:
	shellcheck --version
	shellcheck symbol-new scaffold/symbol

clean:
	rm -rf bin share
