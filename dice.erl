-module(dice).
-export([roll/1, roll/2, roll/3, test/2, dicetype_to_int/0, int_to_dicetype/0]).


dicetype_to_int() ->
    #{
     d4 => 4,
     d6 => 6,
     d8 => 8,
     d10 => 10,
     d12 => 12,
     d20 => 20
    }.


int_to_dicetype() -> utils:map_reversed(dicetype_to_int()).


%% Roll a d4/6/8/10/12/20
roll(DiceType) ->
    rand:uniform(maps:get(DiceType, dicetype_to_int())).


%% Roll a d4/6/8/10/12/20 n times
roll(DiceType, NumRolls) when NumRolls >= 0 ->
    lists:map(
        fun (_) -> roll(DiceType) end,
        lists:seq(1, NumRolls)).


%% Roll a d4/6/8/10/12/20 n times and add the argument bonus
%% ex: 2d6+1 is done by using roll(d6, 2, 1)
roll(DiceType, NumRolls, Mod) when NumRolls >= 0 ->
    lists:sum(roll(DiceType, NumRolls)) + Mod.


test(DiceType, Target) when Target >= 0 ->
    roll(DiceType) =< Target.

