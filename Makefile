# =============================================================================
# Verify that the programs we need to run are installed on this system
# =============================================================================
ERL = $(shell which erl)

ifeq ($(ERL),)
$(error "Erlang not available on this system")
endif

GIT = $(shell which git)

ifeq ($(GIT),)
$(error "Git not available on this system")
endif

REBAR=$(REBAR)

ifeq ($(REBAR),)
$(error "Rebar not available on this system")
endif

.PHONY: all deps update-deps 

all: deps 

# =============================================================================
# Rules to build the system
# =============================================================================

deps:
	$(REBAR) get-deps
	$(REBAR) compile

update-deps:
	$(REBAR) update-deps
	$(REBAR) compile

