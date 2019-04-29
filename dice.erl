-module(dice).
-export([roll/1, roll/2, roll/3, test/2, dicetype_to_int/1, int_to_dicetype/1]).


dicetype_to_int(DiceType)
    when
        DiceType == d4;
        DiceType ==d6;
        DiceType == d8;
        DiceType == d10;
        DiceType == d12;
        DiceType == d20
    ->
    list_to_integer(
        string:trim(
            atom_to_list(DiceType),
            leading,
            "d"
        )
    ).


%% Map integer value to their associated dicetype value
int_to_dicetype(Int)
    when
        Int == 4;
        Int ==6;
        Int == 8;
        Int == 10;
        Int == 12;
        Int == 20
    ->
    list_to_atom(
        string:concat(
            "d",
            integer_to_list(Int)
        )
    ).


%% Roll a d4/6/8/10/12/20
roll(DiceType) ->
    rand:uniform(dicetype_to_int(DiceType)).


%% Roll a d4/6/8/10/12/20 n times
roll(DiceType, NumRolls) when NumRolls >= 0 ->
    lists:map(
        fun (_) -> roll(DiceType) end,
        lists:seq(1, NumRolls)).


%% Roll a d4/6/8/10/12/20 n times and add the argument bonus
%% ex: 2d6+1 is done by using roll(d6, 2, 1)
roll(DiceType, NumRolls, Mod) when NumRolls >= 0 ->
    lists:sum(roll(DiceType, NumRolls)) + Mod.


%% Roll a dice and return whether the obtained value was higher
%% or equal than the target value
test(DiceType, Target) when Target >= 0 ->
    roll(DiceType) =< Target.
