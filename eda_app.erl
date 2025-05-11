-module(eda_app).
-export([start/0, run_demo/0]).

start() ->
    event_bus:start_link(),
    billing_service:start_link(),
    order_service:start_link().

run_demo() ->
    start(),
    timer:sleep(500),
    order_service:place_order("alice@example.com", "Buch"),
    timer:sleep(500),
    order_service:place_order("bob@example.com", "Kartenlesegerät"),
    timer:sleep(500),
    order_service:place_order("charleen@example.com", "Headset").
