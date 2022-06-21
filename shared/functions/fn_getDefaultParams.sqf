#include "..\defines.hpp"
#include "..\bulwark.hpp"

//
// Game parameters
//
// These parameters should be specified in the order they will be displayed, and grouped by
// their category. See PARAMETERS.md for details.
//

private _defaultBulwarkParams = [ 
	//
	// PARAM_CATEGORY_FILTERS
	//
	[ 
		BULWARK_PARAM_FILTER_DLC,
		"Excluded DLC content", PARAM_CATEGORY_FILTERS, PARAM_TYPE_NUMBER, false, 
		[ 
			[0, "None", 0],
			[1, "Contact", 1]
		], 
		0, 
		"Excludes content from the selected DLCs" 
	],
	[ 
		BULWARK_PARAM_FILTER_PRESET,
		"Presets", PARAM_CATEGORY_FILTERS, PARAM_TYPE_NUMBER, false, 
		[
			[0, "Normal", 0],
			[1, "WW2 (IFA3_AIO_LITE)", 1],
			[2, "Global Mobilization", 2],
			[3, "WW2 Winter (IFA_AIO_LITE)", 3],
			[4, "Custom", 4]
		],
		0, 
		"Selects from among the set of advanced, detailed mission parameters not present in this list"
	],
	[ 
		BULWARK_PARAM_FILTER_FACTIONS,
		"Hostile factions", PARAM_CATEGORY_FILTERS, PARAM_TYPE_NUMBER, true, 
		factionOptions,
		["OPF_F"],
		"Select which factions can spawn as enemies"
	],
	//
	// PARAM_CATEGORY_WAVE
	//
	[ 
		BULWARK_PARAM_HOSTILE_MULTIPLIER,
		"Base hostiles wave multiplier", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "Reduced", 0.5],
			[1, "Normal", 1],
			[2, "Double", 2],
			[3, "Triple", 3]
		], 
		1, 
		"The base number of hostiles generated per wave"
	],
	[ 
		BULWARK_PARAM_HOSTILE_TEAM_MULTIPLIER,
		"Hostiles per player multiplier", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
	    [
			[0, "50%", 50],
			[1, "100%", 100],
			[2, "150%", 150],
			[3, "200%", 200]
		],
		0,
		"Additional multiplier on the number of hostiles to add per player"
	],
	[
		BULWARK_PARAM_PISTOL_HOSTILES,
		"Hostiles restricted to pistols until wave", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "Never", 0], 
			[1, "1", 1],
			[2, "2", 2],
			[3, "3", 3],
			[4, "5", 5],
			[5, "10", 10],
			[6, "15", 15],
			[7, "20", 20],
			[8, "25", 25],
			[9,"Always", -1]
		],
		3,
		"Hostiles will only spawn with pistols until the specified wave"
	],
	[
		BULWARK_PARAM_BODY_CLEANUP,
		"Dead bodies remain for this many waves", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[-1, "Immediately removed", -1],
			[0, "Until the next round", 0],
			[1, "1 round", 1],
			[2, "2 rounds", 2]
		],
		0,
		"Dead bodies will remain for the specified number of waves. Higher wave numbers can cause reduced performance and increased lag"
	],
	[
		BULWARK_PARAM_DOWN_TIME,
		"Down time between waves", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "No downtime", 0],
			[1, "15 seconds", 15],
			[2, "30 seconds", 30],
			[3, "60 seconds", 60],
			[4, "90 seconds", 90],
			[5, "2 minutes", 120],
			[6, "3 minutes", 180],
			[7, "4 minutes", 240],
			[8, "5 minutes", 300]
		],
		3,
		"There will be this much time between rounds for you to recuperate, build and search"
	],
	[
		BULWARK_PARAM_MAX_WAVES,
		"Maximum number of waves", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "No limit", 0],
			[1, "20 waves", 20],
			[2, "30 waves", 30],
			[3, "40 waves", 40]
		],
		0,
		"The game will end after this many waves"
	],
	[
		BULWARK_PARAM_SPECIAL_WAVES,
		"Special waves?", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]
		],
		1,
		"Should there be special waves, such as suicide bombers, night time, dense fog, etc. after the first few waves?"
	],
	[
		BULWARK_PARAM_SPECIAL_WAVES_ONLY,
		"Only special waves?", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]
		],
		0,
		"Should there be only be special waves after the first few waves?"
	],
	[
		BULWARK_PARAM_SPECIAL_WAVES_VARIETY,
		"Increase special wave variety?", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]],
		1,
		"Should you not get the same special wave again, until you had every other possible special wave?"
	],
	[
		BULWARK_PARAM_ARMOUR_START_WAVE,
		"Vehicles may spawn after wave", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "Never", 0],
			[1, "5", 5],
			[2, "10", 10],
			[3, "15", 15],
			[4, "20", 20],
			[5, "25", 25]
		],
		1,
		"Vehicles will start to spawn after the specified wave?"
	],
	[
		BULWARK_PARAM_ARMOUR_WAVE_SCALING,
		"Armor spawn budget", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[
			[0, "50%", 0.2],
			[1, "100%", 0.4],
			[2, "150%", 0.6],
			[3, "200%", 0.8]
		],
		1,
		"Controls how much budget is available for spawning vehicles.  Higher means more and more powerful vehicles."
	],

	//
	// PARAM_CATEGORY_START
	//
	[
		BULWARK_PARAM_PLAYER_STARTMAP,
		"Start with a map?", PARAM_CATEGORY_START, PARAM_TYPE_NUMBER, false,
		[ 
			[0, "No", 0],
			[1, "Yes", 1]
		],
		1,
		"Should players start with a map in their inventory?"
	],
	[
		BULWARK_PARAM_PLAYER_STARTWEAPON,
		"Start with a pistol?", PARAM_CATEGORY_START, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]
		],
		0,
		"Should players start with a pistol in their inventory?"
	],
	[
		BULWARK_PARAM_PLAYER_STARTNVG,
		"Start with NVGs?", PARAM_CATEGORY_START, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]
		],
		0,
		"Should players start with NVGs in their inventory?"
	],

	//
	// PARAM_CATEGORY_GAME
	//
	[
		BULWARK_PARAM_RANDOM_WEAPONS,
		"Randomize hostile weapons?", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]
		],
		0,
		"Should enemies have completely randomized weapons?"
	],
	[
		BULWARK_PARAM_LOOT_HOUSE_DENSITY,
		"Minimum buildings near bulwark", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[
			[0, "5", 5],
			[1, "10", 10],
			[2, "15", 15],
			[3, "20", 20],
			[4, "25", 25],
			[5, "30", 30]
		],
		1,
		"The minimum number of buildings which must be near the bulwark to be considered a valid starting location"
	],	
	[
		BULWARK_PARAM_HUD_POINT_HITMARKERS,
		"Point hitmarkers on HUD?", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]
		],
		1,
		"Should there be hit markers on the HUD?"
	],
	[
		BULWARK_PARAM_LOOT_SUPPLYDROP,
		"Supply drop distance", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[
			[0, "Center", 0],
			[1, "Within 25% radius", 25],
			[2, "Within 50% radius", 50],
			[3, "Within 75% radius", 75]
		],
		1,
		"This determines how far from the center of the mission area supply crates will drop"
	],

	//
	// PARAM_CATEGORY_TIME
	//
	[
		BULWARK_PARAM_DAY_TIME_FROM,
		"Earliest mission time start", PARAM_CATEGORY_TIME, PARAM_TYPE_NUMBER, false,
		[
			[11, "0000 hours", 0],
			[0, "0200 hours", 2],
			[1, "0400 hours", 4],
			[2, "0600 hours", 6],
			[3, "0800 hours", 8],
			[4, "1000 hours", 10],
			[5, "1200 hours", 12],
			[6, "1400 hours", 14],
			[7, "1600 hours", 16],
			[8, "1800 hours", 18],
			[9, "2000 hours", 20],
			[10, "2200 hours", 22]
		],
		3,
		"The earliest time of dat the mission will start"
	],
	[
		BULWARK_PARAM_DAY_TIME_TO,
		"Latest mission time start", PARAM_CATEGORY_TIME, PARAM_TYPE_NUMBER, false,
		[
			[11, "0000 hours", 0],
			[0, "0200 hours", 2],
			[1, "0400 hours", 4],
			[2, "0600 hours", 6],
			[3, "0800 hours", 8],
			[4, "1000 hours", 10],
			[5, "1200 hours", 12],
			[6, "1400 hours", 14],
			[7, "1600 hours", 16],
			[8, "1800 hours", 18],
			[9, "2000 hours", 20],
			[10, "2200 hours", 22]
		],
		7,
		"The latest time of day the mission will start"
	],
	[
		BULWARK_PARAM_SEASON,
		"Season to play in", PARAM_CATEGORY_TIME, PARAM_TYPE_NUMBER, false,
		[
			[0, "Spring", 3],
			[1, "Summer", 6],
			[2, "Fall", 9],
			[3, "Winter", 12]
		],
		1,
		"The season in which the game will be played"
	],
	[
		BULWARK_PARAM_TIME_MULTIPLIER,
		"Time multiplier", PARAM_CATEGORY_TIME, PARAM_TYPE_NUMBER, false,
		[
			[0, "Real-time", 1],
			[1, "1hr/20 min", 3],
			[2, "1hr/10 min", 6],
			[3, "1hr/5 min", 12],
			[4, "1hr/3 min", 20],
			[5, "1hr/2 min", 30],
			[6, "1hr/1 min", 60]
		],
		0,
		"The rate at which game time passes. Note church bells ring every 15 minutes game time..."
	],

	//
	// PARAM_CATEGORY_GEOGRAPHY
	//
	[
		BULWARK_PARAM_BULWARK_RADIUS,
		"Mission area size", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, false,
		[
			[0, "Tiny (50m)", 50],
			[1, "Small (100m)", 100],
			[2, "Normal (150m)", 150],
			[3, "Large (200m)", 200],
			[4, "Huge (250m)", 250],
			[5, "Mega Huge (500m)", 500],
			[6, "Ultra Huge (1000m)", 1000]
		],
		2,
		"This is the mission area radius be around the start area"
	],
	[
		BULWARK_PARAM_BULWARK_MINSIZE,
		"Minimum spawn room size", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, false,
		[
			[0, "10m²", 10],
			[1, "13m²", 13],
			[2, "15m²", 15],
			[3, "18m²", 18],
			[4, "20m²", 20]
		],
		1,
		"This is the minimum size the spawn room will be"
	],
	[
		BULWARK_PARAM_LANDRATIO,
		"Minimum land/water ratio", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, false,
		[
			[0, "60%", 60],
			[1, "70%", 70],
			[2, "80%", 80],
			[3, "90%", 90],
			[4, "100%", 100]
		],
		2,
		"This is the minimum ratio of land to water, to avoid spawning on a dock of pier"
	],
	[
		BULWARK_PARAM_BULWARK_POSITION,
		"Starting position", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, false,
		[
			[0, "Random map location", 0],
			[1, "Random marker", 1]
		],
		0,
		"Determines whether the start area will be chosen at random from locations on the map or from among a selection of pre-defined marked locations"
	],
	[
		BULWARK_PARAM_LOCATIONS,
		"Random map locations", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, true,
		[
			[0, "Capital Cities", "NameCityCapital"],
			[1, "Major Cities", "NameCity"],
			[2, "Small Towns", "NameVillage"],
			[3, "Building Clusters", "NameLocal"]
		],
		[0, 1, 2],
		"When the Starting Position is a random map location, which locations should be considered?"
	],

	//
	// PARAM_CATEGORY_BULWARK
	//
	[
		BULWARK_PARAM_BULWARK_MEDIKIT,
		"Medikits in bulwark", PARAM_CATEGORY_BULWARK, PARAM_TYPE_NUMBER, false,
		[],
		3,
		"This many medikits will be in the bulwark at the start of the game"
	],

	//
	// PARAM_CATEGORY_UPGRADES
	//
	[
		BULWARK_PARAM_SUPPORT_MENU,
		"Upgrades require Satellite dish", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]
		],
		1,
		"Do upgrades require the Satellite dish to have been found?"
	],
	[
		BULWARK_PARAM_KILLPOINTS_MODE,
		"How kill points are distributed", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[
			[0, "Personal", KILLPOINTS_MODE_PRIVATE],
			[1, "Shared", KILLPOINTS_MODE_SHARED],
			[2, "Shareable", KILLPOINTS_MODE_SHAREABLE]
		],
		0,
		"Kill points can either be personal, shared among all players, or shared manually by players."
	],
	[
		BULWARK_PARAM_START_KILLPOINTS,
		"Points to start with", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[],
		0,
		"Players will start with this many upgrade points"
	],
	[
		BULWARK_PARAM_SCORE_KILL,
		"Points per kill", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[
			[0, "10", 10],
			[1, "50", 50],
			[2, "100", 100],
			[3, "200", 200],
			[4, "300", 300]
		],
		2,
		"The number of points awarded for each confirmed kill"
	],
	[
		BULWARK_PARAM_SCORE_HIT,
		"Points per hit", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[
			[0, "0", 0],
			[1, "10", 10],
			[2, "20", 20],
			[3, "50", 50],
			[4, "100", 100]
		],
		2,
		"The number of bonus points awarded for each hit"
	],
	[
		BULWARK_PARAM_SCORE_DAMAGE_BASE,
		"Damage bonus points", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[
			[0, "0", 0],
			[1, "10", 10],
			[2, "20", 20],
			[3, "50", 50],
			[4, "100", 100]
		],
		2,
		"The number of bonus points awarded for extra damage"
	],
	[
		BULWARK_PARAM_PARATROOP_COUNT,
		"Paratrooper count", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[
			[0, "1", 1],
			[1, "2", 2],
			[2, "3", 3],
			[3, "4", 4],
			[4, "5", 5],
			[5, "6", 6]
		],
		2,
		"The number of paratroopers dropped when called"
	],

	//
	// PARAM_CATEGORY_PLAYER
	//
	[
		BULWARK_PARAM_REVIVE_ITEMS,
		"Revive required items", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[
			[0, "None", 0],
			[1, "Medikit", 1],
			[2, "FAK or Medikit", 2]
		],
		0,
		"The items which are required to revive another player"
		// bis_fnc_paramReviveRequiredItems;
	],
	[
		BULWARK_PARAM_REVIVE_UNCONSCIOUS_MODE,
		"Revive unconsciousness mode", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[
			[0, "Basic", 0],
			[1, "Advanced", 1],
			[2, "Realistic", 2]
		],
		0,
		"Determines how harsh damage calculations are"
		// BIS_fnc_paramReviveUnconsciousStateMode
	],

	[
		BULWARK_PARAM_RESPAWN_TICKETS,
		"Respawn tickets", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[
			[0, "0", 0],
			[1, "5", 5],
			[2, "10", 10],
			[3, "15", 15],
			[4, "20", 20]
		],
		0,
		"The number of respawn tickets"
	],
	[
		BULWARK_PARAM_RESPAWN_TIME,
		"Respawn time", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[
			[0, "Instant", 0],
			[1, "5 seconds", 5],
			[2, "10 seconds", 10],
			[3, "20 seconds", 20],
			[4, "30 seconds", 30]
		],
		2,
		"The amount of time after using a ticket before the player respawns"
	],
	[
		BULWARK_PARAM_TEAM_DAMAGE,
		"Enable friendly fire?", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[
			[0, "No", 0],
			[1, "Yes", 1]
		],
		1,
		"Whether or not friendly-fire is enabled"
	],
	//
	// PARAM_CATEGORY_LOOT
	//
	[
		BULWARK_PARAM_LOOT_HOUSE_DISTRIBUTION,
		"Loot distribution", PARAM_CATEGORY_LOOT, PARAM_TYPE_NUMBER, false,
		[
			[0, "Every building", 1],
			[1, "Every second building", 2],
			[2, "Every third building", 3],
			[3, "Every fourth building", 4]
		],
		1,
		"This determines which buildings will spawn loot"
	],
	[
		BULWARK_PARAM_LOOT_ROOM_DISTRIBUTION,
		"Loot density", PARAM_CATEGORY_LOOT, PARAM_TYPE_NUMBER, false,
		[
			[0, "Every location", 1],
			[1, "Every second location", 2],
			[2, "Every third location", 3],
			[3, "Every fourth location", 4]
		],
		1,
		"This determines which locations within a building will spawn loot"
	],
	[ 
		BULWARK_PARAM_LOOT_FACTIONS,
		"Loot filter: Factions", PARAM_CATEGORY_LOOT, PARAM_TYPE_NUMBER, true, 
		lootFactionOptions,
		[],
		"Restricts loot by faction. All gear of the selected factions will spawn as loot. Also works together with mod filter. LEAVE BOTH LOOT FILTERS EMPTY TO PLAY WITH EVERYTHING"
	],
	[
		BULWARK_PARAM_LOOT_MODS,
		"Loot filter: Mods", PARAM_CATEGORY_LOOT, PARAM_TYPE_STRING,true,
		modTagOptions,
		[],
		"Restricts loot by mods. All gear of the selected mods will spawn as loot. Also works together with faction filter."
	],
	//
	// PARAM_CATEGORY_WEIGHTEDLOOT
	//
	[
		BULWARK_PARAM_LOOT_ITEMS, 
		"Items",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely items spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_UNIFORMS, 
		"Uniforms",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely uniforms spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_VESTS, 
		"Vests",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely vests spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_BACKPACKS, 
		"Backpacks",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely backpacks spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_HEADGEAR, 
		"Headgear",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely headgear spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_GLASSES,
		"Glasses",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely glasses spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_GRENADES, 
		"Grenades",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely grenades spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_EXPLOSIVE, 
		"Explosives",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely explosives spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_STATICGUN, 
		"Static gun backpacks",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely static gun backpacks spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_AUTOGUN, 
		"Automatic gun backpacks",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely automatic static gun backpacks spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_DRONE, 
		"Drone backpack",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely loot drones spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_MG, 
		"Machine guns",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely machine guns spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_HANDGUN, 
		"Handguns",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely handguns spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_SNIPER, 
		"Sniper Rifles",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely sniper rifles spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_SMG, 
		"Submachine guns",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely submachine guns spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_ASSAULT, 
		"Assault rifles",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely assault rifles spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_LAUNCHER, 
		"Launchers",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely launchers spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_SHOTGUN, 
		"Shotguns",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely shotguns spawn, relative to other items. 0 means it will never spawn"
	],
	[
		BULWARK_PARAM_LOOT_ATTACHMENT, 
		"Weapon attachments",PARAM_CATEGORY_WEIGHTEDLOOT, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"How likely weapon attachments spawn, relative to other items. 0 means it will never spawn"
	],
	//
	// PARAM_CATEGORY_AMOUNTAMMO
	//
	[
		BULWARK_PARAM_AMMO_ASSAULTMIN, 
		"Assault rifle minimum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"Minimum amount of magazines that spawn with an assault rifle"
	],
	[
		BULWARK_PARAM_AMMO_ASSAULTMAX, 
		"Assault rifle maximum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		3,
		"Maximum amount of magazines that spawn with an assault rifle"
	],
	[
		BULWARK_PARAM_AMMO_SMGMIN, 
		"SMG minimum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		2,
		"Minimum amount of magazines that spawn with a submachine gun"
	],
	[
		BULWARK_PARAM_AMMO_SMGMAX, 
		"SMG maximum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		5,
		"Maximum amount of magazines that spawn with a submachine gun"
	],
	[
		BULWARK_PARAM_AMMO_MGMIN, 
		"MG minimum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"Minimum amount of magazines that spawn with a machine gun"
	],
	[
		BULWARK_PARAM_AMMO_MGMAX, 
		"MG maximum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		3,
		"Maximum amount of magazines that spawn with a machine gun"
	],
	[
		BULWARK_PARAM_AMMO_SNIPERMIN, 
		"Sniper minimum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		3,
		"Minimum amount of magazines that spawn with a sniper rifle"
	],
	[
		BULWARK_PARAM_AMMO_SNIPERMAX, 
		"Sniper maximum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		6,
		"Maximum amount of magazines that spawn with a sniper rifle"
	],
	[
		BULWARK_PARAM_AMMO_LAUNCHERMIN, 
		"Launcher minimum rockets",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		1,
		"Minimum amount of magazines that spawn with a Launcher"
	],
	[
		BULWARK_PARAM_AMMO_LAUNCHERMAX, 
		"Launcher maximum rockets",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		2,
		"Maximum amount of magazines that spawn with a Launcher"
	],
	[
		BULWARK_PARAM_AMMO_HANDGUNMIN, 
		"Handgun minimum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		2,
		"Minimum amount of magazines that spawn with a handgun"
	],
	[
		BULWARK_PARAM_AMMO_HANDGUNMAX, 
		"Handgun maximum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		4,
		"Maximum amount of magazines that spawn with a handgun"
	],
	[
		BULWARK_PARAM_AMMO_SHOTGUNMIN, 
		"Shotgun minimum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		4,
		"Minimum amount of magazines that spawn with a shotgun"
	],
	[
		BULWARK_PARAM_AMMO_SHOTGUNMAX, 
		"Shotgun maximum magazines",PARAM_CATEGORY_AMOUNTAMMO, PARAM_TYPE_NUMBER, false,
		[],
		6,
		"Maximum amount of magazines that spawn with a shotgun"
	]
];
_defaultBulwarkParams;
