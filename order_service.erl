-module(order_service).
-behaviour(gen_server).

-export([start_link/0, place_order/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

place_order(User, Item) ->
    gen_server:cast(?MODULE, {place_order, User, Item}).

init([]) -> {ok, undefined}.

handle_call(_, _, State) -> {reply, ok, State}.

handle_cast({place_order, User, Item}, State) ->
    Event = {order_placed, User, Item},
    event_bus:publish(Event),
    io:format("[OrderService] Order placed: ~p~n", [Event]),
    {noreply, State}.

handle_info(_, State) -> {noreply, State}.
terminate(_, _) -> ok.
code_change(_, State, _) -> {ok, State}.
