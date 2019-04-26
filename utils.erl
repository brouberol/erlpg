-module(utils).
-export([list_last_n/2, map_reversed/1]).


% Return the last N elements of the argument list
list_last_n(List, N) when is_list(List), N > 0 ->
    lists:nthtail(length(List) - N, List).


%% Return the reverted Map (values become keys and keys become values)
map_reversed(Map) ->
    maps:from_list(
      lists:map(
        fun({K, V}) -> {V, K} end,
        maps:to_list(Map))).
