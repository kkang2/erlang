%% @author PSJ
%% @doc @todo Add description to startMain.


-module(startMain).

-include_lib("brod/include/brod.hrl").

-behaviour(application).
-export([start/0, stop/0]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).

%% ====================================================================
%% Behavioural functions
%% ====================================================================

start() ->
	application:ensure_all_started(brod),
	ClientConfig = [{reconnect_cool_down_seconds, 10}],
	ok = brod:start_client([{"192.168.137.129", 9092}], brod_client_1, ClientConfig),
	
	brod:start_producer(_Client         = brod_client_1,
                    _Topic          = <<"erlang-test">>,
                    _ProducerConfig = []),
	{ok, CallRef} =
  		brod:produce(_Client    = brod_client_1,
               _Topic     = <<"erlang-test">>,
               _Partition = 0,
               _Key       = <<"some-key-psj">>,
               _Value     = <<"some-value-psj">>).

stop() ->
    ok.

%% ====================================================================
%% Internal functions
%% ====================================================================


