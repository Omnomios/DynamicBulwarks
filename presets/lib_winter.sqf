/**
*  Preset
*  Defines all global config for the mission
*  Required mods: IFA3_AIO_LITE
*  https://steamcommunity.com/workshop/filedetails/?id=660460283
*  Domain: Client, Server
**/
/* MOD FILTER */
modTag = ["LIB"]; //limits loot and vehicles to a specific mod. Mods usually have a tag within their class name, use that. For example modTag = ["LIB"] would only spawn Iron Front Weapons. Can use multiple for example:modTag = ["LIB,"NORTH"];
/* Attacker Waves */
// Use group class names - To leave empty do: HOSTILE_LEVEL_1 = [];
HOSTILE_LEVEL_1 = [];    		//wave 0
HOSTILE_LEVEL_2 = [];       	//wave 5
HOSTILE_LEVEL_3 = [];         	//wave 10
HOSTILE_LEVEL_4 = []; 			//wave 15
DEFECTOR_CLASS = [];          			//defector special wave units
PARATROOP_CLASS = [];          		//friendly units called in via support

//Unit Whitelist - unit classnames are expected for example: HOSTILE_LEVEL_1_WHITELIST = ["B_Soldier_A_F","B_support_MG_F"];
HOSTILE_LEVEL_1_WHITELIST = ["LIB_GER_rifleman_w"]; //adds these units to the hostile levels, if you only want to use the whitelist and not the above groups, leave the groups empty : [];
HOSTILE_LEVEL_2_WHITELIST = ["LIB_GER_rifleman_w","LIB_GER_ober_grenadier_w","LIB_GER_LAT_Rifleman_w","LIB_GER_rifleman_w","LIB_GER_medic_w","LIB_GER_unterofficer_w"];
HOSTILE_LEVEL_3_WHITELIST = ["LIB_GER_ober_rifleman_w","LIB_GER_ober_grenadier_w","LIB_GER_ober_grenadier_w","LIB_GER_LAT_Rifleman_w","LIB_GER_ober_rifleman_w","LIB_GER_medic_w","LIB_GER_unterofficer_w","LIB_GER_Scout_mgunner_w"];
HOSTILE_LEVEL_4_WHITELIST = ["LIB_GER_AT_grenadier_w","LIB_GER_ober_grenadier_w","LIB_GER_Scout_sniper_w","LIB_GER_Mgunner_w","LIB_GER_LAT_Rifleman_w","LIB_GER_AT_soldier_w"];
DEFECTOR_CLASS_WHITELIST = ["LIB_US_Sniper_w","LIB_US_AT_soldier_w","LIB_US_Smgunner_w","LIB_US_Grenadier_w","LIB_US_Mgunner_w"];
PARATROOP_CLASS_WHITELIST = ["LIB_US_AT_soldier_w"];
//Vehicle Whitelist
/* 0 = Adds Whitelist Vehicles to spawn. */
/* 1 = Only Whitelist Vehicles will spawn */
VEHICLE_WHITELIST_MODE = 1;
HOSTILE_ARMED_CARS_WHITELIST = ["LIB_SdKfz_7_AA_w","LIB_SdKfz251_FFV_w","LIB_Kfz1_MG42_sernyt"]; // HOSTILE_ARMED_CARS_WHITELIST = []; to leave empty
HOSTILE_ARMOUR_WHITELIST = ["LIB_SdKfz222","LIB_SdKfz222","LIB_SdKfz222","LIB_FlakPanzerIV_Wirbelwind_w","LIB_PzKpfwIV_H_w","LIB_PzKpfwIV_H_w","LIB_PzKpfwV_w","LIB_PzKpfwVI_B_camo_w","LIB_PzKpfwVI_E_w"];
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
    "I_IR_Grenade",
    "LIB_M2_Tripod",
	"LIB_Laffete_Tripod",
	"LIB_BM37_Tripod",
	"LIB_BM37_Barrel",
	"LIB_GrWr34_Tripod",
	"LIB_GrWr34_Tripod_g",
	"LIB_GrWr34_Barrel",
	"LIB_GrWr34_Barrel_g",
	"LIB_M2_60_Tripod",
	"LIB_M2_60_Barrel",
	"B_LIB_RadioBag",
	"RadioBag",
	"B_LIB_RadioBag_Empty",
	"B_LIB_FunkBag",
	"FunkBag",
	"B_LIB_FunkBag_Empty",
	"LIB_Tripod_Bag",
	"LIB_M2_Tripod_Bag",
	"LIB_BM37_Bag",
	"LIB_GrWr34_Bag",
	"LIB_M2_60_Bag",
	"LIB_MG42_Tripod_Disasm",
	"LIB_MG42_Tripod_High",
	"LIB_Maxim_Bag",
	"B_LIB_GER_Radio",
	"B_LIB_SOV_RA_Radio",
	"B_LIB_US_Radio",
	"B_LIB_GER_Radio_ACRE2",
	"B_LIB_SOV_RA_Radio_ACRE2",
	"B_LIB_US_Radio_ACRE2",
	"B_LIB_GER_Radio_Empty",
	"B_LIB_GER_LW_Paradrop",
	"B_LIB_SOV_RA_Paradrop",
	"B_LIB_SOV_RA_Radio_Empty",
	"B_LIB_US_Type5",
	"B_LIB_US_Radio_Empty",
	"LIB_BM37_Tripod_Deployed",
	"LIB_GrWr34_Tripod_Deployed",
	"LIB_GrWr34_Tripod_Deployed_g",
	"LIB_M2_60_Tripod_Deployed",
	"LIB_Faustpatrone",
	"LIB_PIAT_Rifle",
	"B_LIB_US_TypeA3",
	"LIB_HandGrenade_base"
];
//Loot Chances - chance in % that weapon spawn, spawns a weapon of the following type -- 10 would be 10% chance, 40 would be 40% chance if all combined are 100:
launcherWeapTypeChance =    15;
assaultWeapTypeChance =     30;
smgWeapTypeChance =         25;    //shotguns included in SMG array since there aren't that many
sniperWeapTypeChance =      20;
mgWeapTypeChance =          5;
handgunWeapTypeChance =		5;
//chances in % for what type of item spawns -- 10 would be 10% chance, 40 would be 40% chance if all combined are 100:
clothesTypeChance = 		15;
itemsTypeChance =			10;
weaponsTypeChance =			25;
backpacksTypeChance =		20;
explosivesTypeChance =		30;
//Ammo amount - how many magazines can spawn with weapons [1,3] would be minimum 1 and maximum 3, the maximum is also used to determine how much ammo you get from ammo drops:
magLAUNCHER =	[3,6];
magASSAULT =	[2,5];
magSMG =		[4,6];      //shotguns included in SMG array since there aren't that many
magSNIPER =		[2,4];
magMG =			[2,4];
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
//  "specCivs",
	"ptrdWave"
	];
//comment out the waves you don't like. Don't forget to remove the , behind the last entry
//list of all special waves you can get on higher waves
specialWave_list= [
//	"specCivs",
//	"fogWave",
//	"demineWave",
	"switcharooWave",
	"suicideWave",
	"specMortarWave",
	"nightWave",
	"defectorWave",
    "mgWave",
    "sniperWave",
	"flameWave",	//only works if IFA_AIO_LITE loaded
	"ptrdWave"		//only works if IFA_AIO_LITE loaded
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
   // [3850, "Missile CAS",          "airStrike"], //doesn't work with IFA planes
    [4220, "Mine Cluster Shell",   "mineField"],
    [4690, "Rage Stimpack",         "ragePack"],
    [5930, "Mind Control Gas",    "mindConGas"]
//   [6666, "ARMAKART TM",           "armaKart"],
//    [7500, "Predator Drone",    "droneControl"]
];
//support settings:
casAircraft = "LIB_Pe2"; //CAS aircraft default: "B_Plane_CAS_01_DynamicLoadout_F"
supportAircraft = "LIB_C47_Skytrain"; //Plane that drops support and paratroopers default: "B_T_VTOL_01_vehicle_F"
supportAircraftFlyInHeight = 200; //default: 100
supportAircraftWaypointHeight = 300; //default: 300
supportAircraftSpeed = 150; // adds speed to the aircraft -- default 0

/* Objects the Player can buy */

/* Radius prevents hostiles walking through objects */

/*  Price - Display Name - Class Name - Rotation When Bought - Object Radius (meters) - explosive - invincible - with crew (for autonomous)	*/
BULWARK_BUILDITEMS = [
    [25,   	"Long Plank (8m)",      		"Land_Plank_01_8m_F",             			   	0,		4,		0,	0,     false],
    [50,  	"Junk Barricade",       		"Land_CUP_Ind_Timbers_w",     			    	90,		1.5,	0,	0,     false],
	[50, 	"Hedgehog",						"Land_I44_HedgeHog",							0,		2,		0,	0,     false],
	[50, 	"ConcreteKerb",					"Land_ConcreteKerb_02_2m_F",					0,		1,		0,	0,     false],
    [75,   	"Small Ramp",           		"Land_WoodenRamp",          			    	180,	1.5,	0,	1,     false], //invincible
	[80,   	"Foot Bridge ramp",             "FootBridge_30_ACR",					    	0,		1,		0,	1,     false],
    [85,   	"Flat Triangle (1m)",   		"Land_DomeDebris_01_hex_green_F",  				180,	1.5,	0,	0,     false],
    [100,  	"Short Sandbag Wall",   		"Land_SandbagBarricade_01_half_F",   			0,		1.5,	0,	0,     false],
	[100,  	"Gate",  						"Land_TinWall_01_m_gate_v1_F",					0,		1.5,	0,	0,     false],
    [100,  	"Barbed Wire /w Tank Trap", 	"Wire",   										0,		2,		0,	0,     false],
    [150,  	"Sandbag Barricade (hole)", 	"Land_SandbagBarricade_01_hole_F",   			0,		1.5,	0,	0,     false],
	[150,  	"Sandbag Barricade (Tall)",		"Land_SandbagBarricade_01_F",					0,		1.5,	0,	0,     false],
    [180,  	"Concrete Shelter",     		"Land_CncShelter_F",                 			0,   	1,		0,	0,     false],
    [200,  	"Concrete Walkway",     		"Land_GH_Platform_F",                			0, 		3.5,	0,	0,     false],
    [250,  	"Tall Concrete Wall",   		"Land_Mil_WallBig_4m_F",             			0,		2,		0,	0,     false],
	[250,  	"Shoot House (Prone)",			"Land_Shoot_House_Tunnel_Prone_F",				0,		2,		0,	1,     false], //invincible
	[250,  	"Shoot House (Crouch)",			"Land_Shoot_House_Tunnel_Crouch_F",				0,		2,		0,	1,     false], //invincible
	[250,  	"Shoot House (Stand)",			"Land_Shoot_House_Tunnel_Stand_F",				0,		2,		0,	1,     false], //invincible
	[250,  	"Wood Light Pole",				"Land_PowLines_WoodL",							0,		2,		0,	1,     false],
	[250, 	"Unterstand",         	    	"Land_WW2_BET_Holzverhau_Snow",          		90,  	3,		0,	0,     false],
    [300, 	"Long Concrete Wall",   		"Land_CncBarrierMedium4_F",          			0,  	3,		0,	0,     false],
	[300,	"Stairs Concrete",             	"Land_Podesta_1_stairs4",						0,		1,		0,	1,     false],
	[350,   "Ramp Concrete",		    	"RampConcrete",							    	180,	1,		0,	1,     false],
    [400,  	"Trench Corner",     	    	"Land_WW2_Fortification_Trench_Corner_X2_w",    0, 		4,	    0,	0,     false],
    [400,  	"Trench Bridge",     	    	"Land_WW2_Fortification_Trench_Bridge_w",       0, 		4,  	0,	0,     false],
    [400,  	"Trench Corner 90",    	    	"Land_WW2_Fortification_Trench_Corner_90_w",    0, 		4,  	0,	0,     false],
    [400,  	"Trench Wall",    	         	"Land_WW2_Fortification_Trench_Wall_w",         0, 		4,  	0,	0,     false],
    [400,  	"Trench Wide",    	         	"Land_WW2_Fortification_Trench_Wide_w",         0, 		4,  	0,	0,     false],
    [400, 	"Large Ramp",           		"Land_ConcreteRamp",                			0,  	4,		0,	0,     false],
	[400,	"Wooden Watchtower",		   	"Land_Posed",							    	0,		1,		0,	1,     false],
	[500, 	"Fuel Barrel",					"Land_MetalBarrel_F",		    				0,  	1,		1,	0,     false],	//explosive
    [500, 	"Bunker Block",         		"Land_Bunker_01_blocks_3_F",         			0,  	2,		0,	0,     false],
	[650, 	"Tank Trench",         	    	"Land_WW2_TrenchTank_w",          				0,   	3,		0,	0,     false],
    [750, 	"Ladder",               		"Land_PierLadder_F",                 			0,  	1,		0,	0,     false],
    [750,  	"Trench Bunker",   	         	"Land_WW2_Fortification_Trench_Bunker_FFP",     180, 	4,  	0,	0,     false],
	[750, 	"Static MG42",         			"LIB_MG42_Lafette_Deployed",         			0,  	1,		0,	1,     false],	//invincible
	[750, 	"Static M1919A4 low",   		"LIB_M1919_M2",  				    			0,  	1,		0,	1,     false],	//invincible
	[750, 	"Obstacle - Bridge",   			"Land_prebehlavka",  				   			0,  	1,		0,	1,     false],	//invincible
    [800, 	"Trench Long",   	         	"Land_WW2_Fortification_Trench_Long_X3_w",      0, 		6,  	0,	0,     false],
    [800, 	"Ammo box",    					"LIB_BasicAmmunitionBox_US",                	0,  	1,		0,	1,     false], //invincible
    [950, 	"Stairs",               		"Land_GH_Stairs_F",                  			0,  	4,		0,	1,     false],	//invincible
    [1000, 	"Metal Watchtower",     		"Land_Hlaska",		                			0,		3.5,	0,	0,     false],
    [1000,  "Trench Bunker",   	            "Land_WW2_Fortification_Trench_Bunker_FFP_w",   0,  	4,  	0,	0,     false],
    [1000, 	"Concrete Platform",    		"Land_ConcreteBlock",                  			0,		5,		0,	0,     false],
	[1000, 	"Bag Bunker",					"Land_Fort_Bagfence_Bunker",		  			0,		4,		0,	0,     false],
    [4500, 	"Pillbox",              		"Land_PillboxBunker_01_hex_F",      			90,		5,		0,	0,     false],
	[5000,	"FlaK 30",						"LIB_FlaK_30",									0,		1,		0,	1,     false], //invincible
    [9500, 	"Modular Bunker",       		"Land_Bunker_01_Small_F",          				180,	5,		0,	0,     false],
	[10000,	"Flakvierling 38",				"LIB_Flakvierling_38",							0,  	1,		0,	1,     false], //invincible
	[20000,	"M2 60mm Mortar",				"LIB_M2_60",									0,		1,		0,	1,     false], //invincible
	[20000,	"7.5 cm PaK 40",				"LIB_PAK40",									0,		1,		0,	1, 	   false]  //invincible
];