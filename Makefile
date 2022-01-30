.PHONY: install
install:
	brew bundle install
	rcup -x "Brewfile Brewfile.lock.json Makefile README.md"
