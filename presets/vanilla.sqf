/**
*  Preset
*  Defines all global config for the mission
*  Required mods:
*  Domain: Client, Server
**/
/* MOD FILTER */
modTag = []; //limits loot and vehicles to a specific mod. Mods usually have a tag within their class names, use that. For example modTag = ["LIB"] would only spawn Iron Front Weapons. Can use multiple for example:modTag = ["LIB,"NORTH"];
/* Attacker Waves */
// Use group class names - To leave empty do: HOSTILE_LEVEL_1 = [];
HOSTILE_LEVEL_1 = ["BanditCombatGroup"];                                       //wave 0
HOSTILE_LEVEL_2 = ["OIA_InfSquad","BanditCombatGroup"];                        //wave 5
HOSTILE_LEVEL_3 = ["OIA_InfSquad","BanditCombatGroup","OI_SniperTeam"];                        //wave 10
HOSTILE_LEVEL_4 = ["OI_ViperTeam","OIA_InfSquad","BanditCombatGroup","OI_SniperTeam"];         //wave 15
DEFECTOR_CLASS = ["BUS_InfSquad"];          //defector special wave units
PARATROOP_CLASS = ["BUS_InfSquad"];         //friendly units called in via support

//Unit Whitelist - unit classnames are expected for example: HOSTILE_LEVEL_1_WHITELIST = ["B_Soldier_A_F","B_support_MG_F"];
HOSTILE_LEVEL_1_WHITELIST = []; //adds these units to the hostile levels, if you only want to use the whitelist and not the above groups, to leave empty do [];
HOSTILE_LEVEL_2_WHITELIST = [];
HOSTILE_LEVEL_3_WHITELIST = [];
HOSTILE_LEVEL_4_WHITELIST = [];
DEFECTOR_CLASS_WHITELIST = [];
PARATROOP_CLASS_WHITELIST = [];
//Vehicle Whitelist
/* 0 = Adds Whitelist Vehicles to spawn. */
/* 1 = Only Whitelist Vehicles will spawn */
VEHICLE_WHITELIST_MODE = 0;
HOSTILE_ARMED_CARS_WHITELIST = []; // HOSTILE_ARMED_CARS_WHITELIST = []; to leave empty
HOSTILE_ARMOUR_WHITELIST = [];
//Vehicle Blacklist
HOSTILE_VEHICLE_BLACKLIST = [];

/* LOOT */
Medkit = "Medikit";
LOOT_BLACKLIST = [
    "O_Static_Designator_02_weapon_F", // If players find and place CSAT UAVs they count as hostile units and round will not progress
    "O_UAV_06_backpack_F",
    "O_UAV_06_medical_backpack_F",
    "O_UAV_01_backpack_F",
    "B_IR_Grenade",
    "O_IR_Grenade",
    "I_IR_Grenade"
];
//Loot Chances - chance in % that weapon spawn, spawns a weapon of the following type -- 10 would be 10% chance, 40 would be 40% chance if all combined are 100:
launcherWeapTypeChance =    15;
assaultWeapTypeChance =     35;
smgWeapTypeChance =         20;    //shotguns included in SMG array since there aren't that many
sniperWeapTypeChance =      20;
mgWeapTypeChance =          5;
handgunWeapTypeChance =		5;
//chances in % for what type of item spawns -- 10 would be 10% chance, 40 would be 40% chance if all combined are 100:
clothesTypeChance = 		15;
itemsTypeChance =			10;
weaponsTypeChance =			25;
backpacksTypeChance =		35;
explosivesTypeChance =		25;
//Ammo amount - how many magazines can spawn with weapons [1,3] would be minimum 1 and maximum 3, the maximum is also used to determine how much ammo you get from ammo drops:
magLAUNCHER =	[1,3];
magASSAULT =	[1,3];
magSMG =		[2,5];      //shotguns included in SMG array since there aren't that many
magSNIPER =		[3,6];
magMG =			[1,3];
magHANDGUN =	[2,4];

/* Whitelist modes */
/* 0 = Adds Whitelist Items to loot spawn */
/* 1 = Only Whitelist Items will spawn as loot */
//There must be at least 1 element in each array for Whitelist mode 1, or set the spawn chance of the ones you left empty to 0
//Adding items multiple times increases the chance of them to be spawned.
LOOT_WHITELIST_MODE = 0;
/* Loot Whitelists */
/* Fill with classname arrays: ["example_item_1", "example_item_2"] */
LOOT_WHITELIST_WEAPON_MG = [];
LOOT_WHITELIST_WEAPON_SNIPER = [];
LOOT_WHITELIST_WEAPON_SMG = [];     //shotguns included in SMG array since there aren't that many
LOOT_WHITELIST_WEAPON_ASSAULT = [];
LOOT_WHITELIST_WEAPON_LAUNCHER = [];
LOOT_WHITELIST_WEAPON_HANDGUN = [];
LOOT_WHITELIST_APPAREL = [];
LOOT_WHITELIST_ITEM = [];
LOOT_WHITELIST_EXPLOSIVE = [];
LOOT_WHITELIST_STORAGE = [];

/* POINTS */
SCORE_RANDOMBOX = 950;  // Cost to spin the box
//Point multipliers of SCORE_KILL for different waves
HOSTILE_LEVEL_1_POINT_SCORE = 0.75;
HOSTILE_LEVEL_2_POINT_SCORE = 1;
HOSTILE_LEVEL_3_POINT_SCORE = 1.50;
HOSTILE_LEVEL_4_POINT_SCORE = 1.75;
HOSTILE_CAR_POINT_SCORE = 2;
HOSTILE_ARMOUR_POINT_SCORE = 4;

/* SPECIAL WAVES */
//comment out the waves you don't like. Don't forget to remove the , behind the last entry
//list of special waves you can get early on
lowSpecialWave_list = [
	"fogWave",
	"switcharooWave",
    "specCivs"
];
//comment out the waves you don't like. Don't forget to remove the , behind the last entry
//list of all special waves you can get on higher waves
specialWave_list= [
	"specCivs",
	"fogWave",
	"demineWave",
	"switcharooWave",
	"suicideWave",
	"specMortarWave",
	"nightWave",
	"defectorWave",
    "mgWave",
    "sniperWave"
];
//starting from this wave the lowSpecialWaveList is used
lowSpecialWaveStart = 5;
//starting from this wave the specialWaveList is used
SpecialWaveStart = 10;

/* SUPPORT */
//Comment out or delete the below support items to prevent the player from buying them
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
//support settings:
casAircraft = "B_Plane_CAS_01_DynamicLoadout_F"; //CAS aircraft default: "B_Plane_CAS_01_DynamicLoadout_F"
supportAircraft = "B_T_VTOL_01_vehicle_F"; //Plane that drops support and paratroopers default: "B_T_VTOL_01_vehicle_F"
supportAircraftFlyInHeight = 100; //default: 100
supportAircraftWaypointHeight = 300; //default: 300
supportAircraftSpeed = 20; // adds speed to the aircraft -- default 20

/* Objects the Player can buy */

/* Radius prevents hostiles walking through objects */

/*  Price - Display Name - Class Name - Rotation When Bought - Object Radius (meters) - explosive - invincible - with crew (for autonomous)	*/
BULWARK_BUILDITEMS = [
    [25,    "Long Plank (8m)",        "Land_Plank_01_8m_F",                0,        4,        0,        0,     false],
    [50,    "Junk Barricade",         "Land_Barricade_01_4m_F",            0,      1.5,        0,        0,     false],
    [75,    "Small Ramp (1m)",        "Land_Obstacle_Ramp_F",            180,      1.5,        0,        0,     false],
    [85,    "Flat Triangle (1m)",     "Land_DomeDebris_01_hex_green_F",  180,      1.5,        0,        0,     false],
    [100,   "Short Sandbag Wall",     "Land_SandbagBarricade_01_half_F",   0,      1.5,        0,        0,     false],
    [150,   "Sandbag Tall (hole)",    "Land_SandbagBarricade_01_hole_F",   0,      1.5,        0,        0,     false],
    [150,   "Sandbag Tall",           "Land_SandbagBarricade_01_F",        0,      1.5,        0,        0,     false],
    [180,   "Concrete Shelter",       "Land_CncShelter_F",                 0,        1,        0,        0,     false],
    [180,   "Timber Pile",            "Land_TimberPile_04_F",              0,      3.5,        0,        0,     false],
    [200,   "Timber Pile (sloped)",   "Land_TimberPile_02_F",              0,      3.5,        0,        0,     false],
    [200,   "Concrete Walkway",       "Land_GH_Platform_F",                0,      3.5,        0,        0,     false],
    [250,   "Tall Concrete Wall",     "Land_Mil_WallBig_4m_F",             0,        2,        0,        0,     false],
    [250,   "Guard Box",              "Land_GuardBox_01_brown_F",          0,        2,        0,        0,     false],
    [260,   "Portable Light",         "Land_PortableLight_double_F",     180,        1,        0,        0,     false],
    [300,   "Long Concrete Wall",     "Land_CncBarrierMedium4_F",          0,        3,        0,        0,     false],
    [300,   "Obstacle Bridge",        "Land_Obstacle_Bridge_F",            0,        3,        0,        1,     false],
    [400,   "Large Ramp",             "Land_VR_Slope_01_F",                0,        4,        0,        0,     false],
    [500,   "Bunker Block",           "Land_Bunker_01_blocks_3_F",         0,        2,        0,        0,     false],
    [500,   "Guard Tower (small)",    "Land_GuardTower_02_F",              0,        2,        0,        0,     false],
    [500,   "H Barrier",              "Land_HBarrier_3_F",                 0,        2,        0,        0,     false],
    [500,   "Explosive Barrel",       "Land_MetalBarrel_F",                0,        1,        1,        0,     false],	//explosive
    [750,   "Ladder",                 "Land_PierLadder_F",                 0,        1,        0,        0,     false],
    [800,   "Storage box small",      "Box_NATO_Support_F",                0,        1,        0,        0,     false],
    [950,   "Stairs",                 "Land_GH_Stairs_F",                180,        4,        0,        0,     false],
    [1000,  "Hallogen Lamp",          "Land_LampHalogen_F",               90,        1,        0,        0,     false],
    [1000,  "Double H Barrier",       "Land_HBarrierWall4_F",              0,        4,        0,        0,     false],
    [1000,  "Concrete Platform",      "BlockConcrete_F",                   0,      3.5,        0,        0,     false],
    [1200,  "Storage box large",      "Box_NATO_AmmoVeh_F",                0,        1,        0,        1,     false],    //invincible
    [2500,  "Static HMG",             "B_HMG_01_high_F",                   0,        1,        0,        1,     false],
    [3000,  "Small Bunker",           "Land_BagBunker_Small_F",          180,        3,        0,        0,     false],
    [4500,  "Pillbox",                "Land_PillboxBunker_01_hex_F",      90,      2.5,        0,        0,     false],
    [5000,  "Metal Guard Tower",      "Land_GuardTower_01_F",             90,      2.5,        0,        0,     false],
    [6000,  "Guard Tower",            "Land_Cargo_Patrol_V3_F",            0,      3.5,        0,        0,     false],
    [7000,  "Static GMG",             "B_GMG_01_high_F",                   0,      3.5,        0,        1,     false],
    [9500,  "Modular Bunker",         "Land_Bunker_01_Small_F",          180,        4,        0,        1,     false],
    [25000, "Mortar",                 "B_Mortar_01_F",                   180,      3.5,        0,        1,     false]
];