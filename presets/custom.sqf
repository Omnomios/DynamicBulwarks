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
    "I_IR_Grenade",
    "TrainingMine_01_F",
    "TrainingMine_01_used_F",
    "Item_I_UavTerminal",			// UAV-Terminal
    "Item_O_UavTerminal",
    "Item_I_E_UavTerminal",
    "Item_B_UavTerminal",
    "Item_C_UavTerminal",
    "I_UGV_02_Demining_backpack_F",		// UGV
    "O_UGV_02_Demining_backpack_F",
    "C_IDAP_UGV_02_Demining_backpack_F",
    "I_E_UGV_02_Demining_backpack_F",
    "B_UGV_02_Demining_backpack_F",
    "I_UGV_02_Science_backpack_F",
    "O_UGV_02_Science_backpack_F",
    "I_E_UGV_02_Science_backpack_F",
    "B_UGV_02_Science_backpack_F",
    "O_UAV_06_backpack_F",			// UAV
    "C_UAV_06_backpack_F",
    "I_E_UAV_06_backpack_F",
    "C_IDAP_UAV_06_backpack_F",
    "I_UAV_06_medical_backpack_F",
    "O_UAV_06_medical_backpack_F",
    "B_UAV_06_medical_backpack_F",
    "C_UAV_06_medical_backpack_F",
    "I_E_UAV_06_medical_backpack_F",
    "C_IDAP_UAV_06_medical_backpack_F",
    "I_UAV_01_backpack_F",	
    "O_UAV_01_backpack_F",
    "B_UAV_01_backpack_F",
    "I_E_UAV_01_backpack_F",
    "C_IDAP_UAV_01_backpack_F",	
    "C_IDAP_UAV_06_antimine_backpack_F",	
    "I_HMG_01_high_weapon_F",		// Mk30 HMG
    "I_HMG_01_support_high_F",
    "O_HMG_01_high_weapon_F",
    "O_HMG_01_support_high_F",
    "I_E_HMG_01_high_Weapon_F",
    "I_E_HMG_01_support_high_F",
    "B_HMG_01_high_weapon_F",
    "B_HMG_01_support_high_F",
    "I_HMG_01_weapon_F",
    "I_HMG_01_support_F",
    "O_HMG_01_weapon_F",
    "O_HMG_01_support_F",
    "I_E_HMG_01_Weapon_F",
    "I_E_HMG_01_support_F",
    "B_HMG_01_weapon_F",
    "B_HMG_01_support_F",
    "I_HMG_01_A_weapon_F",
    "O_HMG_01_A_weapon_F",
    "I_E_HMG_01_A_weapon_F",
    "B_HMG_01_A_weapon_F",
    "I_HMG_02_high_weapon_F",		// M2 HMG
    "I_HMG_02_support_high_F",
    "I_G_HMG_02_high_weapon_F",
    "I_G_HMG_02_support_high_F",
    "I_E_HMG_02_high_weapon_F",
    "I_E_HMG_02_support_high_F",
    "I_C_HMG_02_high_weapon_F",
    "I_C_HMG_02_support_high_F",
    "I_HMG_02_weapon_F",
    "I_HMG_02_support_F",
    "I_G_HMG_02_weapon_F",
    "I_G_HMG_02_support_F",
    "I_E_HMG_02_weapon_F",
    "I_E_HMG_02_support_F",
    "I_C_HMG_02_weapon_F",
    "I_C_HMG_02_support_F",
    "I_GMG_01_A_weapon_F",			// static GMG
    "O_GMG_01_A_weapon_F",
    "I_E_GMG_01_A_Weapon_F",
    "B_GMG_01_A_weapon_F",
    "I_GMG_01_high_weapon_F",
    "O_GMG_01_high_weapon_F",
    "I_E_GMG_01_high_Weapon_F",
    "B_GMG_01_high_weapon_F",
    "I_GMG_01_weapon_F",
    "O_GMG_01_weapon_F",
    "I_E_GMG_01_Weapon_F",
    "B_GMG_01_Weapon_F",
    "I_AA_01_weapon_F",			// static Titan
    "O_AA_01_weapon_F",
    "I_E_AA_01_weapon_F",
    "B_AA_01_weapon_F",
    "I_AT_01_weapon_F",
    "O_AT_01_weapon_F",
    "I_E_AT_01_weapon_F",
    "B_AT_01_weapon_F",
    "I_Mortar_01_weapon_F",			// Mortar
    "I_Mortar_01_support_F",
    "O_Mortar_01_weapon_F",
    "O_Mortar_01_support_F",
    "B_Mortar_01_weapon_F",
    "B_Mortar_01_support_F",
    "I_E_Mortar_01_Weapon_F",
    "I_E_Mortar_01_support_F"
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
    [800,  "Recon UAV",            "reconUAV"],
    [1680, "Emergency Teleport",   "telePlode"],
    [1950, "Paratroopers",         "paraDrop"],
    [3850, "Missile CAS",          "airStrike"],
    [4220, "Mine Cluster Shell",   "mineField"],
    [4690, "Rage Stimpack",        "ragePack"],
    [5930, "Mind Control Gas",     "mindConGas"],
    [6666, "ARMAKART TM",          "armaKart"],
    [7500, "Predator Drone",       "droneControl"]
];

// if Radio Mod is present
if (!isNil "acre_main") then {
BULWARK_SUPPORTITEMS pushback [0, "Radio Box (ACRE) for 2min", "radioBox"];
};

if (isClass (configfile >> "CfgVehicles" >> "tf_anarc164")) then {
BULWARK_SUPPORTITEMS pushback [0, "Radio Box (TFAR) for 2min", "radioBox"];
};

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
    [10,    "Holzstamm",              "Land_TimberLog_05_F",               0,        4,        0,        0,        false],
    [25,    "Lange Planke (8m)",      "Land_Plank_01_8m_F",                0,        4,        0,        0,        false],
    [50,    "Holzplanken",            "Land_Target_Single_01_F",           0,        4,        0,        0,        false],
    [75,    "Holzhaufen",             "Land_TimberPile_05_F",              0,        4,        0,        0,        false],
    [85,    "Holz Rampe (1m)",        "Land_Obstacle_Ramp_F",            180,      1.5,        0,        1,        false],
    [95,    "Flaches Dreieck (1m)",   "Land_DomeDebris_01_hex_green_F",  180,      1.5,        0,        0,        false],
    [100,   "Holz Schuppen",          "Land_Shed_12_F",                    0,      1.5,        0,        0,        false],
    [120,   "Schranke",               "Land_RoadBarrier_01_F",             0,      1.5,        0,        0,        false],
    [150,   "Müll Barikade 01",       "Land_GarbageHeap_01_F",             0,      1.5,        0,        0,        false],
    [250,   "Müll Barikade 02",       "Land_Barricade_01_4m_F",            0,      1.5,        0,        0,        false],
    [270,   "Barriere",               "Land_CncBarrier_stripes_F",         0,      1.5,        0,        0,        false],
    [300,   "Lebensmittelsäcke",      "Land_FoodSacks_01_large_brown_F",   0,      1.5,        0,        0,        false],
    [300,   "Fass brennend",          "MetalBarrel_burning_F",             0,        1,        0,        0,        false],
    [350,   "Blechwand",              "Land_Wall_Tin_4",                   0,      1.5,        0,        0,        false],
    [500,   "Aufbewahrungsbox klein", "Box_NATO_Support_F",                0,        1,        0,        1,        false],
    [600,   "kurze Sandsackwand",     "Land_SandbagBarricade_01_half_F",   0,      1.5,        0,        0,        false],
    [650,   "Sandsack Barrikade (Nische)","Land_SandbagBarricade_01_hole_F",0,     1.5,        0,        0,        false],
    [650,   "Sandsack Barrikade",     "Land_SandbagBarricade_01_F",        0,      1.5,        0,        0,        false],
    [680,   "Panzersperre",           "Land_CzechHedgehog_01_old_F",       0,      1.5,        0,        0,        false],
    [700,   "Wohnwagen",              "Land_Caravan_01_green_F",           0,      1.5,        0,        0,        false],
    [700,   "Tragbares Licht",        "Land_PortableLight_double_F",     180,        1,        0,        0,        false],
    [720,   "Leiter",                 "Land_PierLadder_F",                 0,        1,        0,        0,        false],
    [750,   "Gerüst",                 "Land_Scaffolding_F",                0,        1,        0,        0,        false],
    [800,   "Militärwand",            "Land_CamoConcreteWall_01_l_4m_v1_F",0,        2,        0,        0,        false],
    [850,   "Hochsitz",               "Land_DeerStand_01_F",               0,        4,        0,        0,        false],
    [950,   "Treppe",                 "Land_GH_Stairs_F",                180,        4,        0,        0,        false],
    [1000,  "Hallogen Lampe",         "Land_LampHalogen_F",               90,        1,        0,        0,        false],
    [1500,  "Betonunterstand",        "Land_CncShelter_F",                 0,        1,        0,        0,        false],
    [1700,  "Betonweg",               "Land_GH_Platform_F",                0,      3.5,        0,        0,        false],
    [1850,  "Hohe Betonwand",         "Land_Mil_WallBig_4m_F",             0,        2,        0,        0,        false],
    [1900,  "Lange Betonwand",        "Land_CncBarrierMedium4_F",          0,        3,        0,        0,        false],
    [2000,  "Aufbewahrungsbox groß",  "Box_NATO_AmmoVeh_F",                0,        1,        0,        1,        false],
    [2000,  "Verschlag für Wache",    "Land_GuardBox_01_brown_F",          0,        2,        0,        0,        false],
    [2050,  "Brücke",                 "Land_Obstacle_Bridge_F",            0,        3,        0,        1,        false],
    [2100,  "große Rampe flach",      "Land_RampConcrete_F",               0,        4,        0,        0,        false],
    [2100,  "große Rampe steil",      "Land_RampConcreteHigh_F",           0,        4,        0,        0,        false],
    [2100,  "Bunker Block",           "Land_Bunker_01_blocks_3_F",         0,        2,        0,        0,        false],
    [2150,  "Wachturm (klein)",       "Land_GuardTower_02_F",              0,        2,        0,        0,        false],
    [2200,  "H Barriere",             "Land_HBarrier_3_F",                 0,        2,        0,        0,        false],
    [2300,  "Fass mit Benzin",        "Land_MetalBarrel_F",                0,        1,        1,        0,        false],
    [2500,  "Double H Barrier",       "Land_HBarrierWall4_F",              0,        4,        0,        0,        false],
    [2600,  "Beton Plattform",        "BlockConcrete_F",                   0,      3.5,        0,        0,        false],
    [2700,  "statisches HMG groß",    "B_HMG_01_high_F",                   0,        1,        0,        0,        false],
    [3000,  "Sandsack Bunker",        "Land_BagBunker_Small_F",          180,        3,        0,        0,        false],
    [4000,  "Holzhaus",               "Land_Camp_House_01_brown_F",      180,        3,        0,        0,        false],
    [4500,  "Wachturm 01",            "Land_GuardTower_02_F",             90,      2.5,        0,        0,        false],
    [5000,  "statisches M2 .50 groß", "B_G_HMG_02_high_F",                 0,        1,        0,        0,        false],
    [6000,  "Wachturm 02",            "Land_GuardTower_01_F",             90,      3.5,        0,        0,        false],
    [8000,  "Wachturm 03",            "Land_Cargo_Patrol_V3_F",            0,      3.5,        0,        0,        false],
    [9000,  "Wachturm 04",            "Land_ControlTower_01_F",            0,      3.5,        0,        0,        false],
    [10000, "kleiner Bunker",         "Land_PillboxBunker_01_hex_F",      90,      2.5,        0,        0,        false],
    [10000, "autonom. M2 .50 groß",   "B_G_HMG_02_high_F",                 0,        1,        0,        0,         true],
    [10000, "großer Sandsack-Bunker", "Land_BagBunker_Large_F",           90,        5,        0,        0,        false],
    [11000, "autonom. HMG groß",      "B_HMG_01_high_F",       	           0,        1,        0,        0,         true],
    [11000, "statisches GMG groß",    "B_GMG_01_high_F",                   0,      3.5,        0,        0,         true],
    [12000, "modularer Bunker klein", "Land_Bunker_01_Small_F",          180,        4,        0,        0,        false],
    [16000, "Cargo Tower HQ",         "Land_Cargo_HQ_V1_F",                0,      7.5,        0,        0,        false],
    [18000, "statisches M2 .50 klein","B_G_HMG_02_F",       	           0,        1,        0,        0,        false],
    [20000, "autonom. HMG klein",     "B_HMG_01_A_F",       	           0,        1,        0,        0,         true],
    [22000, "autonom. GMG klein",     "B_GMG_01_A_F",                      0,      3.5,        0,        0,         true],
    [24000, "modularer Bunker hoch",  "Land_Bunker_01_tall_F",           180,        4,        0,        0,        false],
    [36000, "autonom. M2 .50 klein",  "B_G_HMG_02_F",       	           0,        1,        0,        0,         true],
    [37000, "Mörser",                 "B_Mortar_01_F",                   180,      3.5,        0,        1,         true],
    [50000, "Cargo Tower sehr hoch",  "Land_Cargo_Tower_V1_F",             0,        1,        0,        0,        false]
];