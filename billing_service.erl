-module(billing_service).
-behaviour(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    event_bus:subscribe(self()),
    {ok, undefined}.

handle_call(_, _, State) -> {reply, ok, State}.
handle_cast(_, State) -> {noreply, State}.

handle_info({event, {order_placed, User, Item}}, State) ->
    io:format("[BillingService] Charging ~p for item ~p~n", [User, Item]),
    {noreply, State};
handle_info(_, State) ->
    {noreply, State}.

terminate(_, _) -> ok.
code_change(_, State, _) -> {ok, State}.
