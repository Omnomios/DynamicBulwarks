/**
*  editMe
*
*  Defines all global config for the mission
*
*  Domain: Client, Server
**/

/* Attacker Waves */

// List_Bandits, List_ParaBandits, List_OPFOR, List_INDEP, List_NATO, List_Viper
HOSTILE_LEVEL_1 = List_Bandits;  // Wave 0 >
HOSTILE_LEVEL_2 = List_OPFOR;    // Wave 5 >
HOSTILE_LEVEL_3 = List_Viper;    // Wave 10 >

HOSTILE_MULTIPLIER = ("HOSTILE_MULTIPLIER" call BIS_fnc_getParamValue);  // How many hostiles per wave (waveCount x HOSTILE_MULTIPLIER)
HOSTILE_TEAM_MULTIPLIER = ("HOSTILE_TEAM_MULTIPLIER" call BIS_fnc_getParamValue) / 100;   // How many extra units are added per player
PISTOL_HOSTILES = ("PISTOL_HOSTILES" call BIS_fnc_getParamValue);  //What wave enemies stop only using pistols

// List_LocationMarkers, List_AllCities
BULWARK_LOCATIONS = List_AllCities;
BULWARK_RADIUS = ("BULWARK_RADIUS" call BIS_fnc_getParamValue);
BULWARK_MINSIZE = ("BULWARK_MINSIZE" call BIS_fnc_getParamValue);   // Spawn room must be bigger than x square metres
BULWARK_LANDRATIO = ("BULWARK_LANDRATIO" call BIS_fnc_getParamValue);
LOOT_HOUSE_DENSITY = ("LOOT_HOUSE_DENSITY" call BIS_fnc_getParamValue);

PLAYER_STARTEQUIPMENT = ("PLAYER_STARTEQUIPMENT" call BIS_fnc_getParamValue);
PLAYER_STARTVISION = ("PLAYER_STARTVISION" call BIS_fnc_getParamValue);
PLAYER_STARTWEAPON = if ("PLAYER_STARTWEAPON" call BIS_fnc_getParamValue == 1) then {true} else {false};
PLAYER_STARTNVG    = if ("PLAYER_STARTNVG" call BIS_fnc_getParamValue == 1) then {true} else {false};

/* Respawn */
RESPAWN_TIME = ("RESPAWN_TIME" call BIS_fnc_getParamValue);
RESPAWN_TICKETS = ("RESPAWN_TICKETS" call BIS_fnc_getParamValue);

/* Loot Blacklist */
LOOT_BLACKLIST = [
    "example_item1",
    "example_item2",
    "example_item3"
];

/* Loot Spawn */
LOOT_WEAPON_POOL    = List_AllWeapons - LOOT_BLACKLIST;    // Classnames of Loot items as an array
LOOT_APPAREL_POOL   = List_AllClothes + List_Vests - LOOT_BLACKLIST;
LOOT_ITEM_POOL      = List_Optics + List_Items - LOOT_BLACKLIST;
LOOT_EXPLOSIVE_POOL = List_Mines - LOOT_BLACKLIST;
LOOT_STORAGE_POOL   = List_Backpacks - LOOT_BLACKLIST;

/* Random Loot */
LOOT_HOUSE_DISTRIBUTION = ("LOOT_HOUSE_DISTRIBUTION" call BIS_fnc_getParamValue);  // Every *th house will spwan loot.
LOOT_ROOM_DISTRIBUTION = ("LOOT_ROOM_DISTRIBUTION" call BIS_fnc_getParamValue);   // Every *th position, within that house will spawn loot.
LOOT_DISTRIBUTION_OFFSET = 0; // Offset the position by this number.
LOOT_SUPPLYDROP = ("LOOT_SUPPLYDROP" call BIS_fnc_getParamValue) / 100;        // Radius of supply drop
PARATROOP_COUNT = ("PARATROOP_COUNT" call BIS_fnc_getParamValue);
PARATROOP_CLASS = List_NATO;

/* Points */
SCORE_KILL = ("SCORE_KILL" call BIS_fnc_getParamValue);                 // Every kill
SCORE_HIT = ("SCORE_HIT" call BIS_fnc_getParamValue);                   // Every Bullet hit that doesn't result in a kill
SCORE_DAMAGE_BASE = ("SCORE_DAMAGE_BASE" call BIS_fnc_getParamValue);   // Extra points awarded for damage. 100% = SCORE_DAMAGE_BASE. 50% = SCORE_DAMAGE_BASE/2
SCORE_RANDOMBOX = 950;  // Cost to spin the box

BULWARK_SUPPORTITEMS = [
    [800,  "Recon UAV",     "reconUAV"],
    [1950, "Paratroopers",  "paraDrop"],
    [5430, "Missle CAS",    "airStrike"],
    [5930, "Rage Stimpack", "ragePack"],
    [6666, "ARMAKART TM",   "armaKart"]
];

/* Price - Display Name - Class Name - Rotation When Held */
BULWARK_BUILDITEMS = [
    [50,   "Junk Barricade",       "Land_Barricade_01_4m_F",            0],
    [100,  "Short Sandbag Wall",   "Land_SandbagBarricade_01_half_F",   0],
    [150,  "Sandbag Barricade",    "Land_SandbagBarricade_01_hole_F",   0],
    [250,  "Tall Concrete Wall",   "Land_Mil_WallBig_4m_F",             0],
    [400,  "Ramp",                 "Land_VR_Slope_01_F",                0],
    [500,  "H Barrier",            "Land_HBarrier_3_F",                 0],
    [750,  "Ladder",               "Land_PierLadder_F",                 0],
    [800,  "Storage box small",    "Box_NATO_Support_F",                0],
    [1000, "Hallogen Lamp",        "Land_LampHalogen_F",              180],
    [1000, "Double H Barrier",     "Land_HBarrierWall4_F",              0],
    [1200, "Storage box large",    "Box_NATO_AmmoVeh_F",                0],
    [2500, "Machine Gun",          "B_HMG_01_F",                        0],
    [2500, "Machine Gun (raised)", "B_HMG_01_high_F",                   0],
    [3000, "Small Bunker",         "Land_BagBunker_Small_F",            0],
    [5000, "Guard Tower",          "Land_Cargo_Patrol_V3_F",          180]
];

/* Time of Day*/
DAY_TIME_FROM = ("DAY_TIME_FROM" call BIS_fnc_getParamValue);
DAY_TIME_TO = ("DAY_TIME_TO" call BIS_fnc_getParamValue);

// Check for sneaky inverted configuration. FROM should always be before TO.
if (DAY_TIME_FROM > DAY_TIME_TO) then {
    DAY_TIME_FROM = DAY_TIME_TO - 2;
};

/* Starter MediKits */
BULWARK_MEDIKITS = ("BULWARK_MEDIKIT" call BIS_fnc_getParamValue);
