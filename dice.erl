-module(dice).
-export([roll/1, roll/2, roll/3, test/2]).


%% Roll a d4/6/8/10/12/20
roll(DiceType) ->
    case DiceType of
        d4 -> rand:uniform(4);
        d6 -> rand:uniform(6);
        d8 -> rand:uniform(8);
        d10 -> rand:uniform(10);
        d12 -> rand:uniform(12);
        d20 -> rand:uniform(20)
    end.


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

