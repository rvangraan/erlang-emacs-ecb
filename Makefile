# =============================================================================
# Verify that the programs we need to run are installed on this system
# =============================================================================
REPODIR = $(shell pwd)

ERL = $(shell which erl)

ifeq ($(ERL),)
$(error "Erlang not available on this system")
endif

GIT = $(shell which git)

ifeq ($(GIT),)
$(error "Git not available on this system")
endif

REBAR=$(shell which rebar)

ifeq ($(REBAR),)
$(error "Rebar not available on this system")
endif

.PHONY: all deps update-deps symlinks

all: deps symlinks

# =============================================================================
# Rules to build the system
# =============================================================================

deps:
	$(REBAR) get-deps
	$(REBAR) compile

update-deps:
	$(REBAR) update-deps
	$(REBAR) compile

symlinks:
	@if [ ! -h ~/.emacs.d ]; then \
		echo "Setting up symlink to ~/.emacs.d/"; \
		ln -s $(REPODIR) ~/.emacs.d; \
	fi
