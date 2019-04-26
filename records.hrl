-record(character, {name,
                    race,
                    class,
                    level,
                    pv,
                    initiative,
                    defense,
                    right_weapon,
                    left_weapon,
                    stats}).


-record(stats, {strength=0,
                dexterity=0,
                constitution=0,
                intelligence=0,
                wisdom=0,
                charisma=0 }).


-record(weapon, {name,
                 type="melee",
                 family,
                 mul_factor=1,
                 damage,
                 damage_bonus=0,
                 hands=1}).


-record(armor, {name,
                defense}).
