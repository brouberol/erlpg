-module(utils).
-export([list_last_n/2]).


% Return the last N elements of the argument list
list_last_n(List, N) when is_list(List), N > 0 ->
    lists:nthtail(length(List) - N, List).
