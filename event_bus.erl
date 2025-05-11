-module(event_bus).
-behaviour(gen_server).

-export([start_link/0, subscribe/1, publish/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {subscribers = []}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

subscribe(Pid) ->
    gen_server:cast(?MODULE, {subscribe, Pid}).

publish(Event) ->
    gen_server:cast(?MODULE, {publish, Event}).

init([]) ->
    {ok, #state{}}.

handle_call(_Req, _From, State) ->
    {reply, ok, State}.

handle_cast({subscribe, Pid}, State = #state{subscribers = Subs}) ->
    {noreply, State#state{subscribers = [Pid | Subs]}};

handle_cast({publish, Event}, State = #state{subscribers = Subs}) ->
    lists:foreach(fun(P) -> P ! {event, Event} end, Subs),
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

terminate(_, _) -> ok.
code_change(_, State, _) -> {ok, State}.
