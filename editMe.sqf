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
HOSTILE_MULTIPLIER = 1;          // How many hostiles per wave (waveCount x HOSTILE_MULTIPLIER)
HOSTILE_TEAM_MULTIPLIER = 0.5;   // How many extra units are added per player

// List_LocationMarkers, List_AllCities
BULWARK_LOCATIONS = List_AllCities;
BULWARK_RADIUS = 150;
BULWARK_MINSIZE = 13;   // Spawn room must be bigger than x square metres

/* Loot Spawn */
LOOT_WEAPON_POOL    = List_AllWeapons;    // Classnames of Loot items as an array
LOOT_APPAREL_POOL   = List_AllClothes;
LOOT_ITEM_POOL      = List_Optics + List_Items;
LOOT_EXPLOSIVE_POOL = List_Mines;
LOOT_STORAGE_POOL   = List_AllStorage;

/* Random Loot */
LOOT_HOUSE_DISTRIBUTION = 2;  // Every *th house will spwan loot.
LOOT_ROOM_DISTRIBUTION = 3;   // Every *th position, within that house will spawn loot.
LOOT_DISTRIBUTION_OFFSET = 0; // Offset the position by this number.
LOOT_DEBUG = FALSE;           // Shows loot as markers on the map
LOOT_SUPPLYDROP = 0.2;        // Radius of supply drop
PARATROOP_COUNT = 3;
PARATROOP_CLASS = List_NATO;

/* Points */
SCORE_KILL = 100;       // Every kill
SCORE_HIT = 10;         // Every Bullet hit that doesn't result in a kill
SCORE_DAMAGE_BASE = 20; // Extra points awarded for damage. 100% = SCORE_DAMAGE_BASE. 50% = SCORE_DAMAGE_BASE/2
SCORE_RANDOMBOX = 950;  // Cost to spin the box

BULWARK_SUPPORTITEMS = [
    [800,  "Recon UAV",     "reconUAV"],
    [1950, "Paratroopers",  "paraDrop"],
    [5430, "Missle CAS",    "airStrike"],
    [8930, "Rage Stimpack", "ragePack"]
];

BULWARK_BUILDITEMS = [
    [50,   "Junk Barricade",       "Land_Barricade_01_4m_F"],
    [100,  "Short Sandbag Wall",   "Land_SandbagBarricade_01_half_F"],
    [150,  "Sandbag Barricade",    "Land_SandbagBarricade_01_hole_F"],
    [250,  "Tall Concrete Wall",   "Land_Mil_WallBig_4m_F"],
    [500,  "H Barrier",            "Land_HBarrier_3_F"],
    [1000, "Double H Barrier",     "Land_HBarrierWall4_F"],
    [2500, "Machine Gun",          "B_HMG_01_F"],
    [2500, "Machine Gun (raised)", "B_HMG_01_high_F"],
    [5000, "Guard Tower",          "Land_Cargo_Patrol_V3_F"]
];

/* Time of Day*/
DAYTIMEFROM = 6; //earliest time. 6 = 6:00 AM
DAYTIMETO = 18; //earliest time. 18 = 6:00 PM
