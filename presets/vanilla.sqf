/**
*  Preset
*  Defines all global config for the mission
*  Required mods:
*  Domain: Client, Server
**/
/* Attacker Waves */
//Unit Whitelist - unit classnames are expected for example: HOSTILE_LEVEL_1_WHITELIST = ["B_Soldier_A_F","B_support_MG_F"];
HOSTILE_INFANTRY_WHITELIST = [];
DEFECTOR_CLASS_WHITELIST = []; //defector special wave units
PARATROOP_CLASS_WHITELIST = []; //friendly units called in via support

HOSTILE_VEHICLE_WHITELIST = [];
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
//LOOT WHITELISTS, when a whitelist contains an element it is used instead of what the game grabs from factions:
LOOT_WHITELIST_UNIFORMS = [];
LOOT_WHITELIST_VESTS = [];
LOOT_WHITELIST_HEADGEAR = [];
LOOT_WHITELIST_BACKPACKS = [];
LOOT_WHITELIST_STATICGUNS = [];
LOOT_WHITELIST_AUTOSTATICGUNS = [];
LOOT_WHITELIST_STATICSUPPORTS = [];
LOOT_WHITELIST_DRONES = [];
LOOT_WHITELIST_GLASSES = [];
LOOT_WHITELIST_ITEMS = [];
LOOT_WHITELIST_ATTACHMENT = [];
LOOT_WHITELIST_GRENADES = [];
LOOT_WHITELIST_EXPLOSIVES = [];
LOOT_WHITELIST_MG = [];
LOOT_WHITELIST_SMG = [];
LOOT_WHITELIST_SNIPER = [];
LOOT_WHITELIST_SHOTGUN = [];
LOOT_WHITELIST_HANDGUN = [];
LOOT_WHITELIST_LAUNCHER = [];
LOOT_WHITELIST_ASSAULT = [];

/* POINTS */
SCORE_RANDOMBOX = 950;  // Cost to spin the box
//Point multipliers of SCORE_KILL for different waves
HOSTILE_LEVEL_1_POINT_SCORE = 0.75;
HOSTILE_LEVEL_2_POINT_SCORE = 1;
HOSTILE_LEVEL_3_POINT_SCORE = 1.50;
HOSTILE_LEVEL_4_POINT_SCORE = 1.75;
HOSTILE_INFANTRY_POINT_SCORE = 0.75;
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

/*  Price - Display Name - Class Name - Rotation When Bought - Object Radius (meters) - explosive - invincible -  Has AI true/false (for objects with AI like autonomous turrests)	*/
BULWARK_BUILDITEMS = [
    [25,    "Long Plank (8m)",        "Land_Plank_01_8m_F",                0,        4,        0,        0,        false],
    [50,    "Junk Barricade",         "Land_Barricade_01_4m_F",            0,      1.5,        0,        0,        false],
    [75,    "Small Ramp (1m)",        "Land_Obstacle_Ramp_F",            180,      1.5,        0,        0,        false],
    [85,    "Flat Triangle (1m)",     "Land_DomeDebris_01_hex_green_F",  180,      1.5,        0,        0,        false],
    [100,   "Short Sandbag Wall",     "Land_SandbagBarricade_01_half_F",   0,      1.5,        0,        0,        false],
    [150,   "Sandbag Tall (hole)",    "Land_SandbagBarricade_01_hole_F",   0,      1.5,        0,        0,        false],
    [150,   "Sandbag Tall",           "Land_SandbagBarricade_01_F",        0,      1.5,        0,        0,        false],
    [180,   "Concrete Shelter",       "Land_CncShelter_F",                 0,        1,        0,        0,        false],
    [180,   "Timber Pile",            "Land_TimberPile_04_F",              0,      3.5,        0,        0,        false],
    [200,   "Timber Pile (sloped)",   "Land_TimberPile_02_F",              0,      3.5,        0,        0,        false],
    [200,   "Concrete Walkway",       "Land_GH_Platform_F",                0,      3.5,        0,        0,        false],
    [250,   "Tall Concrete Wall",     "Land_Mil_WallBig_4m_F",             0,        2,        0,        0,        false],
    [250,   "Guard Box",              "Land_GuardBox_01_brown_F",          0,        2,        0,        0,        false],
    [260,   "Portable Light",         "Land_PortableLight_double_F",     180,        1,        0,        0,        false],
    [300,   "Long Concrete Wall",     "Land_CncBarrierMedium4_F",          0,        3,        0,        0,        false],
    [300,   "Obstacle Bridge",        "Land_Obstacle_Bridge_F",            0,        3,        0,        1,        false],
    [400,   "Large Ramp",             "Land_VR_Slope_01_F",                0,        4,        0,        0,        false],
    [500,   "Bunker Block",           "Land_Bunker_01_blocks_3_F",         0,        2,        0,        0,        false],
    [500,   "Guard Tower (small)",    "Land_GuardTower_02_F",              0,        2,        0,        0,        false],
    [500,   "H Barrier",              "Land_HBarrier_3_F",                 0,        2,        0,        0,        false],
    [500,   "Explosive Barrel",       "Land_MetalBarrel_F",                0,        1,        1,        0,        false],
    [750,   "Ladder",                 "Land_PierLadder_F",                 0,        1,        0,        0,        false],
    [800,   "Storage box small",      "Box_NATO_Support_F",                0,        1,        0,        0,        false],
    [950,   "Stairs",                 "Land_GH_Stairs_F",                180,        4,        0,        0,        false],
    [1000,  "Hallogen Lamp",          "Land_LampHalogen_F",               90,        1,        0,        0,        false],
    [1000,  "Double H Barrier",       "Land_HBarrierWall4_F",              0,        4,        0,        0,        false],
    [1000,  "Concrete Platform",      "BlockConcrete_F",                   0,      3.5,        0,        0,        false],
    [1200,  "Storage box large",      "Box_NATO_AmmoVeh_F",                0,        1,        0,        1,        false],
    [2500,  "Static HMG",             "B_HMG_01_high_F",                   0,        1,        0,        1,        false],
    [3000,  "Small Bunker",           "Land_BagBunker_Small_F",          180,        3,        0,        0,        false],
    [4500,  "Pillbox",                "Land_PillboxBunker_01_hex_F",      90,      2.5,        0,        0,        false],
    [4500,  "Static HMG Autonomous",  "B_HMG_01_high_F",                   0,        1,        0,        0,         true],
    [5000,  "Metal Guard Tower",      "Land_GuardTower_01_F",             90,      2.5,        0,        0,        false],
    [6000,  "Guard Tower",            "Land_Cargo_Patrol_V3_F",            0,      3.5,        0,        0,        false],
    [7000,  "Static GMG",             "B_GMG_01_high_F",                   0,      3.5,        0,        1,        false],
    [9500,  "Static GMG Autonomous",  "B_GMG_01_high_F",                   0,      3.5,        0,        0,         true],
    [9500,  "Modular Bunker",         "Land_Bunker_01_Small_F",          180,        4,        0,        1,        false],
    [25000, "Mortar",                 "B_Mortar_01_F",                   180,      3.5,        0,        1,        false]
];