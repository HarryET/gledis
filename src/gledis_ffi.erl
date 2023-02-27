-module(gledis_ffi).
-export([null/0, coerce/1, connect/0, connect_with_opts/1, close/1, query/2]).

null() ->
    null.

coerce(Value) ->
    Value.

connect() -> eredis:start_link().
connect_with_opts(Options) -> eredis:start_link(Options).

close(pid) -> eredis:stop(pid).

query(client, command) -> eredis:q(client, command).
