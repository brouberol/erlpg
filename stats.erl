-module(stats).
-export([new/0, new/1, carac_mod/1, add/2]).
-include("records.hrl").

%% Initialize a new stats record with random values
new() -> 
    #stats{
        strength = roll_charac(),
        dexterity = roll_charac(),
        constitution = roll_charac(),
        intelligence = roll_charac(),
        wisdom = roll_charac(),
        charisma = roll_charac()}.

    

%% Return a new stats record filled with argument values
new(StatValues) ->
    {STR, DEX, CON, INT, WIS, CHA} = StatValues,
    #stats{
       strength = STR,
       dexterity = DEX,
       constitution = CON,
       intelligence = INT,
       wisdom = WIS,
       charisma = CHA}.


add(Stats1, Stats2) -> 
    #stats{
       strength = Stats1#stats.strength + Stats2#stats.strength,
       dexterity = Stats1#stats.dexterity + Stats2#stats.dexterity,
       constitution = Stats1#stats.constitution + Stats2#stats.constitution,
       intelligence = Stats1#stats.intelligence + Stats2#stats.intelligence,
       wisdom = Stats1#stats.wisdom + Stats2#stats.wisdom,
       charisma = Stats1#stats.charisma + Stats2#stats.charisma}.


%% keep the highest 3 rolls of 4 rolls of a d6 and return the sum of the highest 3 rolls
roll_charac() ->
    lists:sum(
      utils:list_last_n(
        dice:roll(d6, 4),
        3)).


%% Return the modifier of a given characteristic according to its value
carac_mod(CaracValue) when CaracValue >= 1, CaracValue =< 21 ->
    if
        CaracValue =< 3 -> -4;
        CaracValue =< 5 -> -3;
        CaracValue =< 7 -> -2;
        CaracValue =< 9 -> -1;
        CaracValue =< 11 -> 0;
        CaracValue =< 13 -> 1;
        CaracValue =< 15 -> 2;
        CaracValue =< 17 -> 3;
        CaracValue =< 19 -> 4;
        CaracValue =< 21 -> 5
    end.

