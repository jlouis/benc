PROJECT = benc

.DEFAULT_GOAL := app

# Options.
CT_SUITES = benc
PLT_APPS = 

# Dependencies.

#TEST_DEPS = eqcmini
#dep_eqcmini = https://github.com/jlouis/eqcmini.git

# Standard targets.

eqc-ci: app
	erlc test/*_eqc.erl -o ebin

include erlang.mk

