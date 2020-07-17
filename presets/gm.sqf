/**
*  Preset
*  Defines all global config for the mission
*  Required mods: Global Mobilisation
*  https://store.steampowered.com/app/1042220/Arma_3_Creator_DLC_Global_Mobilization__Cold_War_Germany/
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
Medkit = "gm_ge_army_medkit_80";
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
    [25,    "Long Plank (8m)",        "Land_Plank_01_8m_F",                     0,        4,        0,        0,        false],
    [25,    "Tank Traps",             "land_gm_tanktrap_01",                    0,        4,        0,        0,        false],
    [25,    "Barbed Wire",            "land_gm_barbedwire_02",                  0,        4,        0,        0,        false],
    [50,    "Junk Barricade",         "Land_Barricade_01_4m_F",                 0,      1.5,        0,        0,        false],
    [50,   "Round Sandbag Low",       "land_gm_sandbags_01_low_01",             0,      1.5,        0,        0,        false],
    [75,    "Small Ramp (1m)",        "Land_Obstacle_Ramp_F",                 180,      1.5,        0,        0,        false],
    [85,    "Flat Triangle (1m)",     "Land_DomeDebris_01_hex_green_F",       180,      1.5,        0,        0,        false],
    [100,   "Fence",                  "land_gm_fence_border_gz1_600",           0,      1.5,        0,        0,        false],
    [100,   "Fence Gate",             "land_gm_fence_border_gz1_gate_350_r",    0,      1.5,        0,        0,        false],
    [100,   "Sandbag Short",          "land_gm_sandbags_01_short_01",           0,      1.5,        0,        0,        false],
    [150,   "Sandbag Barricade",      "land_gm_sandbags_01_door_01",            0,      1.5,        0,        0,        false],
    [150,   "Sandbag Wall",           "land_gm_sandbags_01_wall_01",            0,      1.5,        0,        0,        false],
    [180,   "Sandbag Half Circle",    "land_gm_sandbags_01_round_01",           0,      1.5,        0,        0,        false],
    [180,   "Concrete Shelter",       "Land_CncShelter_F",                      0,        1,        0,        0,        false],
    [200,   "Concrete Walkway",       "Land_GH_Platform_F",                     0,      3.5,        0,        0,        false],
    [250,   "Tall Concrete Wall",     "Land_Mil_WallBig_4m_F",                  0,        2,        0,        0,        false],
    [300,   "Long Concrete Wall",     "Land_CncBarrierMedium4_F",               0,        3,        0,        0,        false],
    [400,   "Large Ramp",             "Land_VR_Slope_01_F",                     0,        4,        0,        0,        false],
    [500,   "Bunker Block",           "Land_Bunker_01_blocks_3_F",              0,        2,        0,        0,        false],
    [500,   "H Barrier",              "Land_HBarrier_3_F",                      0,        2,        0,        0,        false],
    [500,   "Explosive Barrel",       "gm_barrel_rusty",                        0,        1,        1,        0,        false],
    [750,   "Ladder",                 "Land_PierLadder_F",                      0,        1,        0,        0,        false],
    [800,   "Storage box",            "gm_AmmoBox_3Rnd_40mm_heat_pg7v_rpg7",    0,        1,        0,        0,        false],
    [950,   "Stairs",                 "Land_GH_Stairs_F",                     180,        4,        0,        0,        false],
    [1000,  "Lamp",                   "land_gm_ge_lamp_06_01",                 90,        1,        0,        0,        false],
    [1000,  "Double H Barrier",       "Land_HBarrierWall4_F",                   0,        4,        0,        0,        false],
    [1000,  "Concrete Platform",      "BlockConcrete_F",                        0,      3.5,        0,        0,        false],
    [2000, "Viewing Platform",        "land_gm_euro_misc_viewplatform_01",    180,        3,        0,        0,        false],
    [2500,  "Launcher tripod",        "gm_ge_army_milan_launcher_tripod",       0,        1,        0,        1,        false],
    [3000,  "Small Bunker",           "Land_BagBunker_Small_F",               180,        3,        0,        0,        false],
    [4500,  "Pillbox",                "Land_PillboxBunker_01_hex_F",           90,      2.5,        0,        0,        false],
    [5000,  "Launcher tripod Auto",   "gm_ge_army_milan_launcher_tripod",       0,        1,        0,        1,        true],
    [6500, "Tall Tower",              "land_gm_tower_bt_11_60",                90,        3,        0,        0,        false],
    [9500,  "Modular Bunker",         "Land_Bunker_01_Small_F",               180,      3.5,        0,        0,        false]
];