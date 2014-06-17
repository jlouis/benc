PROJECT = benc

.DEFAULT_GOAL := app

# Options.
CT_SUITES = benc
PLT_APPS = 

# Dependencies.

#TEST_DEPS = eqcmini
#dep_eqcmini = https://github.com/jlouis/eqcmini.git

# Standard targets.

eqc-ci: all
	erlc -o ebin test/*_eqc.erl

include erlang.mk

