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

REBAR=./rebar

ifeq ($(REBAR),)
$(error "Rebar not available on this system")
endif

.PHONY: all rebar-deps deps update-deps symlinks edts

all: rebar-deps symlinks edts

# =============================================================================
# Rules to build the system
# =============================================================================

rebar-deps:
	$(REBAR) get-deps
	$(REBAR) compile

DEPS = $(sort $(dir $(wildcard deps/*/)))

		
update-deps:
	$(REBAR) update-deps
	$(REBAR) compile

symlinks:
	@if [ ! -h ~/.emacs.d ]; then \
		echo "Setting up symlink to ~/.emacs.d/"; \
		ln -s $(REPODIR) ~/.emacs.d; \
	fi



deps/%/:
	echo $@
	if [ -f $@/Makefile ]; then \
		make -C $@ all ; \
	fi

edts:	rebar-deps
	cd deps/edts
	make -C deps/edts all

		