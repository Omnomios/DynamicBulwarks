#include "..\..\shared\bulwark.hpp"

HOSTILE_MULTIPLIER = BULWARK_PARAM_HOSTILE_MULTIPLIER call shared_fnc_getCurrentParamValue;  // How many hostiles per wave (waveCount x HOSTILE_MULTIPLIER)
HOSTILE_TEAM_MULTIPLIER = (BULWARK_PARAM_HOSTILE_TEAM_MULTIPLIER call shared_fnc_getCurrentParamValue) / 100;   // How many extra units are added per player
PISTOL_HOSTILES = (BULWARK_PARAM_PISTOL_HOSTILES call shared_fnc_getCurrentParamValue);  //What wave enemies stop only using pistols
RANDOM_WEAPONS = if ((BULWARK_PARAM_RANDOM_WEAPONS call shared_fnc_getCurrentParamValue) == 1) then {true} else {false};
BULWARK_RADIUS = (BULWARK_PARAM_BULWARK_RADIUS call shared_fnc_getCurrentParamValue);
BULWARK_MINSIZE = (BULWARK_PARAM_BULWARK_MINSIZE call shared_fnc_getCurrentParamValue);   // Spawn room must be bigger than x square metres
BULWARK_LANDRATIO = (BULWARK_PARAM_LANDRATIO call shared_fnc_getCurrentParamValue);
LOOT_HOUSE_DENSITY = (BULWARK_PARAM_LOOT_HOUSE_DENSITY call shared_fnc_getCurrentParamValue);
PLAYER_STARTWEAPON = if ((BULWARK_PARAM_PLAYER_STARTWEAPON call shared_fnc_getCurrentParamValue) == 1) then {true} else {false};
PLAYER_STARTMAP    = if ((BULWARK_PARAM_PLAYER_STARTMAP call shared_fnc_getCurrentParamValue) == 1) then {true} else {false};
PLAYER_STARTNVG    = if ((BULWARK_PARAM_PLAYER_STARTNVG call shared_fnc_getCurrentParamValue) == 1) then {true} else {false};
/* Respawn */
RESPAWN_TIME = (BULWARK_PARAM_RESPAWN_TIME call shared_fnc_getCurrentParamValue);
RESPAWN_TICKETS = (BULWARK_PARAM_RESPAWN_TICKETS call shared_fnc_getCurrentParamValue);
/* Random Loot */
LOOT_HOUSE_DISTRIBUTION = (BULWARK_PARAM_LOOT_HOUSE_DISTRIBUTION call shared_fnc_getCurrentParamValue);  // Every *th house will spwan loot.
LOOT_ROOM_DISTRIBUTION = (BULWARK_PARAM_LOOT_ROOM_DISTRIBUTION call shared_fnc_getCurrentParamValue);   // Every *th position, within that house will spawn loot.
LOOT_DISTRIBUTION_OFFSET = 0; // Offset the position by this number.

LOOT_SUPPLYDROP = (BULWARK_PARAM_LOOT_SUPPLYDROP call shared_fnc_getCurrentParamValue) / 100; // Radius of supply drop as a percentage of BULWARK_RADIUS
PARATROOP_COUNT = (BULWARK_PARAM_PARATROOP_COUNT call shared_fnc_getCurrentParamValue);
SCORE_KILL = (BULWARK_PARAM_SCORE_KILL call shared_fnc_getCurrentParamValue);                 // Base Points for a kill
SCORE_HIT = (BULWARK_PARAM_SCORE_HIT call shared_fnc_getCurrentParamValue);                   // Every Bullet hit that doesn't result in a kill
SCORE_DAMAGE_BASE = (BULWARK_PARAM_SCORE_DAMAGE_BASE call shared_fnc_getCurrentParamValue);   // Extra points awarded for damage. 100% = SCORE_DAMAGE_BASE. 50% = SCORE_DAMAGE_BASE/2
/* Time of Day*/
DAY_TIME_FROM = (BULWARK_PARAM_DAY_TIME_FROM call shared_fnc_getCurrentParamValue);
DAY_TIME_TO = (BULWARK_PARAM_DAY_TIME_TO call shared_fnc_getCurrentParamValue);
// Check for sneaky inverted configuration. FROM should always be before TO.
if (DAY_TIME_FROM > DAY_TIME_TO) then {
    DAY_TIME_FROM = DAY_TIME_TO - 2;
};
/* Starter MediKits */
BULWARK_MEDIKITS = (BULWARK_PARAM_BULWARK_MEDIKIT call shared_fnc_getCurrentParamValue);
DOWN_TIME = (BULWARK_PARAM_DOWN_TIME call shared_fnc_getCurrentParamValue);

/* Special Wave parameters */
enableSpecialWaves = if ((BULWARK_PARAM_SPECIAL_WAVES call shared_fnc_getCurrentParamValue) == 1) then {true} else {false};
everyWaveSpecial = if ((BULWARK_PARAM_SPECIAL_WAVES_ONLY call shared_fnc_getCurrentParamValue) == 1) then {true} else {false};
specialWaveRepeat = if ((BULWARK_PARAM_SPECIAL_WAVES_VARIETY call shared_fnc_getCurrentParamValue) == 1) then {false} else {true};

/* Other wave parameters */
BODY_CLEANUP_WAVE = (BULWARK_PARAM_BODY_CLEANUP call shared_fnc_getCurrentParamValue);
ARMOUR_START_WAVE = BULWARK_PARAM_ARMOUR_START_WAVE call shared_fnc_getCurrentParamValue;
ARMOUR_WAVE_SCALING = BULWARK_PARAM_ARMOUR_WAVE_SCALING call shared_fnc_getCurrentParamValue;