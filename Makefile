README = README.md
INSTALL_DIR = /usr/local/bin

all: lint install

lint: lint-scripts lint-readme

lint-scripts:
	shellcheck git-pull-all git-clone-all

lint-readme:
	markdownlint README.md

install:
	cp git-pull-all git-clone-all /usr/local/bin

uninstall:
	rm /usr/local/bin/git-pull-all
	rm /usr/local/bin/git-pull-all

.PHONY: all lint lint-scripts lint-readme install uninstall
