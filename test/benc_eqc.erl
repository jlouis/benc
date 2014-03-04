-module(benc_eqc).

-export([r/0, prop_inv/0, bcode/0]).

-include_lib("eqc/include/eqc.hrl").

bcode() ->
    ?SIZED(Size, g_bcode(Size)).

g_bcode(0) ->
    oneof([int(), binary(), []]);
g_bcode(N) ->
    frequency(
    	[{5, g_bcode(0)},
    	 {1,
    	   ?LAZY(list(g_bcode(N div 2)))},
    	 {1,
    	   ?LAZY(list({binary(), g_bcode(N div 2)}))}
    ]).

prop_inv() ->
    ?FORALL(BC, bcode(),
            begin
                Enc = iolist_to_binary(benc:encode(BC)),
                {ok, Dec} = benc:decode(Enc),
                benc:encode(BC) =:= benc:encode(Dec)
            end).

r() ->
	eqc:module({numtests, 200}, ?MODULE).
