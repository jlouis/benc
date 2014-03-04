-module(benc_SUITE).

-include_lib("common_test/include/ct.hrl").

%% ct.
-export([all/0]).

%% Tests.
-export([eqc/1]).

%% ct.

all() ->
	[eqc].

eqc(_) ->
	[] = eqc:module(benc_eqc).


