-module(utils).
-export([list_last_n/2, map_reversed/1, debug/1, debugstr/1]).


% Return the last N elements of the argument list
list_last_n(List, N) when is_list(List), N > 0 ->
    lists:nthtail(length(List) - N, List).


%% Return the reverted Map (values become keys and keys become values)
map_reversed(Map) when is_map(Map) ->
    maps:from_list(
      lists:map(
        fun({K, V}) -> {V, K} end,
        maps:to_list(Map))).


%% Display a debug header before the argument string
debugstr(Str) ->
    string:concat("[DEBUG] ", Str).


%% Print the argument list of values
debug(ListValues) when is_list(ListValues) ->
    PATTERN = string:concat(
        string:join(
            ["~p" || _ <- ListValues],
            ", "
        ),
        " ~n"),
    io:fwrite(debugstr(PATTERN), ListValues);


%% Print the argument map of K/V as 'K1: V1, K2: V2, ...'
debug(Map) when is_map(Map) ->
    PATTERN = string:concat(
        string:join(
            ["~s: ~p" || _ <- maps:to_list(Map)],
            ", "
        ),
        " ~n"),
    io:fwrite(
        debugstr(PATTERN),
        lists:flatten(
            lists:map(fun(T) -> tuple_to_list(T) end,
            maps:to_list(Map)))).
