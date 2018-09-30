prefix := $(HOME)/.local
bindir := $(prefix)/bin
sharedir := $(prefix)/share/symbol

default:
	@echo "usage:"
	@echo "  make install [prefix=<prefix>]"
	@echo "  make lint"
	@echo "  make test"

install:
	mkdir -p $(bindir) $(sharedir)
	install symbol-new $(bindir)
	cp -rv scaffold $(sharedir)

lint:
	shellcheck --version
	shopt -s globstar
	shellcheck symbol-new scaffold/symbol ./**/*.sh

test:
	./run-tests.sh

clean:
	rm -rf bin share
