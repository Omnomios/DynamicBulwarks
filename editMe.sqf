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
HOSTILE_ARMED_CARS = List_Armour;//expects vehicles
HOSTILE_ARMOUR = List_ArmedCars; //expects vehicles

HOSTILE_MULTIPLIER = ("HOSTILE_MULTIPLIER" call BIS_fnc_getParamValue);  // How many hostiles per wave (waveCount x HOSTILE_MULTIPLIER)
HOSTILE_TEAM_MULTIPLIER = ("HOSTILE_TEAM_MULTIPLIER" call BIS_fnc_getParamValue) / 100;   // How many extra units are added per player
PISTOL_HOSTILES = ("PISTOL_HOSTILES" call BIS_fnc_getParamValue);  //What wave enemies stop only using pistols

/* LOCATION LIST OPTIONS */
// List_AllCities - for any random City
// List_SpecificPoint - will start the mission on the "Specific Bulwark Pos" marker (move with mission editor). Location must meet BULWARK_LANDRATIO and LOOT_HOUSE_DENSITY, BULWARK_MINSIZE, etc requirements
// List_LocationMarkers - for a location selected randomly from the Bulwark Zones in editor (Currently broken)
// *IMPORTANT* If you get an error using List_SpecificPoint it means that there isn't a building that qualifies. Turning down the "Minimum spawn room size" parameter might help.
BULWARK_LOCATIONS = List_AllCities;

BULWARK_RADIUS = ("BULWARK_RADIUS" call BIS_fnc_getParamValue);
BULWARK_MINSIZE = ("BULWARK_MINSIZE" call BIS_fnc_getParamValue);   // Spawn room must be bigger than x square metres
BULWARK_LANDRATIO = ("BULWARK_LANDRATIO" call BIS_fnc_getParamValue);
LOOT_HOUSE_DENSITY = ("LOOT_HOUSE_DENSITY" call BIS_fnc_getParamValue);

PLAYER_STARTWEAPON = if ("PLAYER_STARTWEAPON" call BIS_fnc_getParamValue == 1) then {true} else {false};
PLAYER_STARTMAP    = if ("PLAYER_STARTMAP" call BIS_fnc_getParamValue == 1) then {true} else {false};
PLAYER_STARTNVG    = if ("PLAYER_STARTNVG" call BIS_fnc_getParamValue == 1) then {true} else {false};

/* Respawn */
RESPAWN_TIME = ("RESPAWN_TIME" call BIS_fnc_getParamValue);
RESPAWN_TICKETS = ("RESPAWN_TICKETS" call BIS_fnc_getParamValue);

/* Loot Blacklist */
LOOT_BLACKLIST = [
    "O_Static_Designator_02_weapon_F", // If players find and place CSAT UAVs they count as hostile units and round will not progress
    "O_UAV_06_backpack_F",
    "O_UAV_06_medical_backpack_F",
    "O_UAV_01_backpack_F",
    "B_IR_Grenade",
    "O_IR_Grenade",
    "I_IR_Grenade"
];
//chance in % that weapon spawn, spawns a weapon of the following type -- 10 would be 10% chance, 40 would be 40% chance if all combined are 100:
launcherWeapTypeChance =    10;
assaultWeapTypeChance =     30;
smgWeapTypeChance =         30;
sniperWeapTypeChance =      20;
mgWeapTypeChance =          10;
handgunWeapTypeChance =		0;  //handguns don't spawn currently
//chances in % for what type of item spawns -- 10 would be 10% chance, 40 would be 40% chance if all combined are 100:
clothesTypeChance = 		15;
itemsTypeChance =			10;
weaponsTypeChance =			20;
backpacksTypeChance =		20;
explosivesTypeChance =		15;
ammoTypeChance =            20;
//how many magazines can spawn with weapons [1,3] would be minimum 1 and maximum 3:
magLAUNCHER =	[1,3];
magASSAULT =	[1,3];
magSMG =		[4,6];
magSNIPER =		[4,8];
magMG =			[1,1];
magHANDGUN =	[2,4];  //handguns don't spawn currently
/* Whitelist modes */
/* 0 = Off */
/* 1 = Only Whitelist Items will spawn as loot */
/* 2 = Whitelist items get added to existing loot (increases the chance of loot spawning */
LOOT_WHITELIST_MODE = 0;

/* Loot Whitelists */
/* Fill with classname arrays: ["example_item_1", "example_item_2"] */
/* To use Whitelisting there MUST be at least one applicaple item in each LOOT_WHITELIST array*/
LOOT_WHITELIST_WEAPON_MG = [];
LOOT_WHITELIST_WEAPON_SNIPER = [];
LOOT_WHITELIST_WEAPON_SMG = [];
LOOT_WHITELIST_WEAPON_ASSAULT = [];
LOOT_WHITELIST_WEAPON_LAUNCHER = [];
LOOT_WHITELIST_WEAPON_HANDGUN = []; //doesn't work currently
LOOT_WHITELIST_APPAREL = [];
LOOT_WHITELIST_ITEM = [];
LOOT_WHITELIST_EXPLOSIVE = [];
LOOT_WHITELIST_STORAGE = [];

/* Random Loot */
LOOT_HOUSE_DISTRIBUTION = ("LOOT_HOUSE_DISTRIBUTION" call BIS_fnc_getParamValue);  // Every *th house will spwan loot.
LOOT_ROOM_DISTRIBUTION = ("LOOT_ROOM_DISTRIBUTION" call BIS_fnc_getParamValue);   // Every *th position, within that house will spawn loot.
LOOT_DISTRIBUTION_OFFSET = 0; // Offset the position by this number.
LOOT_SUPPLYDROP = ("LOOT_SUPPLYDROP" call BIS_fnc_getParamValue) / 100;        // Radius of supply drop
PARATROOP_COUNT = ("PARATROOP_COUNT" call BIS_fnc_getParamValue);
PARATROOP_CLASS = List_NATO;
DEFECTOR_CLASS = List_NATO;

/* Points */
SCORE_KILL = ("SCORE_KILL" call BIS_fnc_getParamValue);                 // Base Points for a kill
SCORE_HIT = ("SCORE_HIT" call BIS_fnc_getParamValue);                   // Every Bullet hit that doesn't result in a kill
SCORE_DAMAGE_BASE = ("SCORE_DAMAGE_BASE" call BIS_fnc_getParamValue);   // Extra points awarded for damage. 100% = SCORE_DAMAGE_BASE. 50% = SCORE_DAMAGE_BASE/2
SCORE_RANDOMBOX = 950;  // Cost to spin the box

/*Point multipliers of SCORE_KILL for different waves */
HOSTILE_LEVEL_1_POINT_SCORE = 0.75;
HOSTILE_LEVEL_2_POINT_SCORE = 1;
HOSTILE_LEVEL_3_POINT_SCORE = 1.50;
HOSTILE_CAR_POINT_SCORE = 2;
HOSTILE_ARMOUR_POINT_SCORE = 4;

/* Special Waves */
//comment out the waves you don't like. Don't forget to remove the , behind the last entry
//list of special waves you can get early on
lowSpecialWave_list = [
	"fogWave",
	"swticharooWave",
    "specCivs"
	];
//comment out the waves you don't like. Don't forget to remove the , behind the last entry
//list of all special waves you can get on higher waves
specialWave_list= [
	"specCivs",
	"fogWave",
	"demineWave",
	"swticharooWave",
	"suicideWave",
	"specMortarWave",
	"nightWave",
	"defectorWave"
];
//starting from this wave the lowSpecialWaveList is used
lowSpecialWaveStart = 5;
//starting from this wave the specialWaveList is used
SpecialWaveStart = 10;
//If true, every time special waves spawn it could be any of the set special waves
//If false, you can't get a repeat of the same special wave type, until  all special waves happend once
specialWaveRepeat = false;
//if true, every wave starting with the lowSpecialWaveStart will be a special wave
everyWaveSpecial = false;

/* Comment out or delete the below support items to prevent the player from buying them */

BULWARK_SUPPORTITEMS = [
    [800,  "Recon UAV",             "reconUAV"],
    [1680, "Emergency Teleport",   "telePlode"],
    [1950, "Paratroopers",          "paraDrop"],
    [3850, "Missile CAS",          "airStrike"],
    [4220, "Mine Cluster Shell",   "mineField"],
    [4690, "Rage Stimpack",         "ragePack"],
    [5930, "Mind Control Gas",    "mindConGas"],
    [6666, "ARMAKART TM",           "armaKart"],
    [7500, "Predator Drone",    "droneControl"]
];

/* Objects the Player can buy */

/* Radius prevents hostiles walking through objects */

/*  Price - Display Name - Class Name - Rotation When Bought - Object Radius (meters) - explosive - invincible	*/
BULWARK_BUILDITEMS = [
    [25,    "Long Plank (8m)",        "Land_Plank_01_8m_F",                0,        4,        0,        0],
    [50,    "Junk Barricade",         "Land_Barricade_01_4m_F",            0,      1.5,        0,        0],
    [75,    "Small Ramp (1m)",        "Land_Obstacle_Ramp_F",            180,      1.5,        0,        0],
    [85,    "Flat Triangle (1m)",     "Land_DomeDebris_01_hex_green_F",  180,      1.5,        0,        0],
    [100,   "Short Sandbag Wall",     "Land_SandbagBarricade_01_half_F",   0,      1.5,        0,        0],
    [150,   "Sandbag Barricade",      "Land_SandbagBarricade_01_hole_F",   0,      1.5,        0,        0],
    [180,   "Concrete Shelter",       "Land_CncShelter_F",                 0,        1,        0,        0],
    [200,   "Concrete Walkway",       "Land_GH_Platform_F",                0,      3.5,        0,        0],
    [250,   "Tall Concrete Wall",     "Land_Mil_WallBig_4m_F",             0,        2,        0,        0],
    [260,   "Portable Light",         "Land_PortableLight_double_F",     180,        1,        0,        0],
    [300,   "Long Concrete Wall",     "Land_CncBarrierMedium4_F",          0,        3,        0,        0],
    [400,   "Large Ramp",             "Land_VR_Slope_01_F",                0,        4,        0,        0],
    [500,   "Bunker Block",           "Land_Bunker_01_blocks_3_F",         0,        2,        0,        0],
    [500,   "H Barrier",              "Land_HBarrier_3_F",                 0,        2,        0,        0],
    [500,   "Explosive Barrel",       "Land_MetalBarrel_F",                0,        1,        1,        0],	//explosive
    [750,   "Ladder",                 "Land_PierLadder_F",                 0,        1,        0,        0],
    [800,   "Storage box small",      "Box_NATO_Support_F",                0,        1,        0,        0],
    [950,   "Stairs",                 "Land_GH_Stairs_F",                180,        4,        0,        0],
    [1000,  "Hallogen Lamp",          "Land_LampHalogen_F",               90,        1,        0,        0],
    [1000,  "Double H Barrier",       "Land_HBarrierWall4_F",              0,        4,        0,        0],
    [1000,  "Concrete Platform",      "BlockConcrete_F",                   0,      3.5,        0,        0],
    [1200,  "Storage box large",      "Box_NATO_AmmoVeh_F",                0,        1,        0,        1],    //invincible
    [2500,  "Static HMG",             "B_HMG_01_high_F",                   0,        1,        0,        0],
    [3000,  "Small Bunker",           "Land_BagBunker_Small_F",          180,        3,        0,        0],
    [4500,  "Pillbox",                "Land_PillboxBunker_01_hex_F",      90,      2.5,        0,        0],
    [6000,  "Guard Tower",            "Land_Cargo_Patrol_V3_F",            0,      3.5,        0,        0],
    [9500,  "Modular Bunker",         "Land_Bunker_01_Small_F",          180,      3.5,        0,        0]
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

//do not edit below unless you know what your doing!
/* Loot Spawn */
if (LOOT_WHITELIST_MODE != 1) then {
    LOOT_WEAPON_POOL    = List_AllWeapons - LOOT_BLACKLIST;
    LOOT_APPAREL_POOL   = List_AllClothes + List_Vests - LOOT_BLACKLIST;
    LOOT_ITEM_POOL      = List_Optics + List_Items - LOOT_BLACKLIST;
    LOOT_EXPLOSIVE_POOL = List_Mines + List_Grenades + List_Charges - LOOT_BLACKLIST;
    LOOT_STORAGE_POOL   = List_Backpacks - LOOT_BLACKLIST;
    LOOT_WEAPON_MG_POOL = List_MG - LOOT_BLACKLIST;
    LOOT_WEAPON_HANDGUN_POOL = List_Secondaries - LOOT_BLACKLIST;
    LOOT_WEAPON_SNIPER_POOL = List_Sniper - LOOT_BLACKLIST;
    LOOT_WEAPON_SMG_POOL = List_SMG - LOOT_BLACKLIST;
    LOOT_WEAPON_ASSAULT_POOL = List_Assault - LOOT_BLACKLIST;
    LOOT_WEAPON_LAUNCHER_POOL = List_Launchers - LOOT_BLACKLIST;
}
else
{
    LOOT_WEAPON_POOL    = LOOT_WHITELIST_WEAPON_MG + LOOT_WHITELIST_WEAPON_SNIPER + LOOT_WHITELIST_WEAPON_SMG + LOOT_WHITELIST_WEAPON_ASSAULT + LOOT_WHITELIST_WEAPON_LAUNCHER + LOOT_WHITELIST_WEAPON_HANDGUN;
    LOOT_APPAREL_POOL   = LOOT_WHITELIST_APPAREL;
    LOOT_ITEM_POOL      = LOOT_WHITELIST_ITEM;
    LOOT_EXPLOSIVE_POOL = LOOT_WHITELIST_EXPLOSIVE;
    LOOT_STORAGE_POOL   = LOOT_WHITELIST_STORAGE;
    LOOT_WEAPON_MG_POOL = LOOT_WHITELIST_WEAPON_MG;
    LOOT_WEAPON_HANDGUN_POOL = LOOT_WHITELIST_WEAPON_HANDGUN;
    LOOT_WEAPON_SNIPER_POOL = LOOT_WHITELIST_WEAPON_SNIPER;
    LOOT_WEAPON_SMG_POOL = LOOT_WHITELIST_WEAPON_SMG;
    LOOT_WEAPON_ASSAULT_POOL = LOOT_WHITELIST_WEAPON_ASSAULT;
    LOOT_WEAPON_LAUNCHER_POOL = LOOT_WHITELIST_WEAPON_LAUNCHER;
};