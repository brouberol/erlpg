-module(weapon).
-export([dicetype/1]).
-include("records.hrl").


dicetype(Weapon) ->
    case Weapon#weapon.damage of
        4 -> d4;
        6 -> d6;
        8 -> d8;
        10 -> d10;
        12 -> d12;
        20 -> d20
    end.

