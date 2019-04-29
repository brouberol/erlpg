-module(weapon).
-export([dicetype/1]).
-include("records.hrl").


%% Return the dicetype (eg d4, d6, etc) of the argument weapon
dicetype(Weapon) -> dice:int_to_dicetype(Weapon#weapon.damage).

