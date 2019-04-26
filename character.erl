-module(character).
-export([new/3, new/4, equip_weapon/3, take_damage/2, attack_melee/3]).
-include("records.hrl").


new(Name, Race, Class, Stats) ->
    RACE_STATS = apply_race_stats_modifiers(Race, Stats),
    #character{
       name = Name,
       race = Race,
       class = Class,
       level = 1,
       pv = pv(Class, RACE_STATS),
       initiative = initiative(RACE_STATS),
       defense = defense(RACE_STATS),
       right_weapon = #weapon{name="fist", family="hand", damage=4},
       left_weapon = #weapon{name="fist", family="hand", damage=4},
       stats = RACE_STATS}.

new(Name, Race, Class) -> new(Name, Race, Class, stats:new()).


pv(Class, Stats) ->
    INITIAL_PV = case Class of
        arquebusier -> 8;
        barbarian -> 12;
        bard -> 6;
        knight -> 10;
        druid -> 8;
        sorcerer -> 4;
        spellcrafter -> 6;
        warrior -> 10;
        mage -> 4;
        monk -> 8;
        priest -> 8;
        thief -> 6;
        ranger -> 8
    end,
    CON_MOD = stats:carac_mod(Stats#stats.constitution),
    INITIAL_PV + CON_MOD.


initiative(Stats) -> Stats#stats.dexterity.


defense(Stats) -> 10 + stats:carac_mod(Stats#stats.dexterity).


apply_race_stats_modifiers(Race, Stats) ->
    RACE_STATS_MOD = case Race of
        semi_elf -> #stats{constitution=-2, wisdom=2};
        semi_ork -> #stats{strength=2, intelligence=-2, charisma=-2};
        high_elf -> #stats{charisma=2, strength=-2};
        wood_elf -> #stats{dexterity=2, strength=-2};
        human    -> #stats{};
        dwarf    -> #stats{constitution=2, dexterity=-2};
        gnome    -> #stats{intelligence=2, strength=-2};
        halfling -> #stats{dexterity=2, strength=-2}
    end,
    stats:add(Stats, RACE_STATS_MOD).


equip_weapon(Character, Weapon, Hand) ->
    case Hand of
        left -> Character#character{left_weapon = Weapon};
        right -> Character#character{right_weapon = Weapon}
    end.


roll_weapon_dm(Weapon) ->
    dice:roll(
      weapon:dicetype(Weapon),
      Weapon#weapon.mul_factor,
      Weapon#weapon.damage_bonus
    ).


take_damage(Character, Damage) ->
    NEW_PV = Character#character.pv - Damage,
    Character#character{pv = NEW_PV}.


inflict_damage(Character, Target, Weapon) ->
    DM = roll_weapon_dm(Weapon),
    CHAR_STATS = Character#character.stats,
    MOD = stats:carac_mod(CHAR_STATS#stats.strength),
    DAMAGE = DM + MOD,
    take_damage(Target, DAMAGE).


attack_melee(Character, Target, Hand) ->
    WEAPON = case Hand of
        left -> Character#character.left_weapon;
        right -> Character#character.right_weapon
    end,
    SUCCESSFUL_ATTACK = dice:test(d20, Target#character.defense),
    if
        SUCCESSFUL_ATTACK -> inflict_damage(Character, Target, WEAPON);
        not SUCCESSFUL_ATTACK -> true
    end.


