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
	rm -rf scaffold/src/.cm
	cp -rv scaffold $(sharedir)

shell_files := $(shell find . -type f -name '*.sh')
lint:
	shellcheck --version
	shellcheck symbol-new scaffold/symbol $(shell_files)


update :=

test:
	./run-tests.sh $(if $(update),--update,)

clean:
	rm -rf bin share
