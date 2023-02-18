-module(gledis_ffi).
-export([connect/0, close/1, query/2]).

connect() -> eredis:start_link().

close(pid) -> eredis:stop(pid).

query(client, command) -> eredis:q(client, command).
