#include "..\defines.hpp"
#include "..\bulwark.hpp"

//
// Game parameters
//
// These parameters should be specified in the order they will be displayed, and grouped by
// their category.
//
//
// Parameter format:
// <parameter id>,
// <parameter title>, <parameter category name>, <parameter type>, <is multi-select>,
// <array of options which are title-value pairs>,
// <default value, or values if multi-select>,
// <long description of the parameter>
//

private _defaultBulwarkParams = [ 
	//
	// PARAM_CATEGORY_FILTERS
	//
	[ 
		BULWARK_PARAM_FILTER_DLC,
		"Excluded DLC content", PARAM_CATEGORY_FILTERS, PARAM_TYPE_NUMBER, false, 
		[ ["None", 0], ["Contact", 1] ], 
		0, 
		"Excludes content from the selected DLCs" 
	],
	[ 
		BULWARK_PARAM_FILTER_PRESET,
		"Presets", PARAM_CATEGORY_FILTERS, PARAM_TYPE_NUMBER, false, 
		[ ["Normal", 0], ["WW2 (IFA3_AIO_LITE)", 1], ["Global Mobilization", 2], ["WW2 Winter (IFA_AIO_LITE)", 3], ["WW2 Winter (IFA_AIO_LITE)", 3], ["Custom", 4] ],
		0, 
		"Selects from among the set of advanced, detailed mission parameters not present in this list"
	],
	[ 
		BULWARK_PARAM_FILTER_FACTIONS,
		"Factions", PARAM_CATEGORY_FILTERS, PARAM_TYPE_NUMBER, true, 
		[["Option 1", 0], ["Option 2", 1], ["Option 3", 2], ["Option 4", 3], ["Option 5", 4], ["Option 6", 5], ["Option 7", 6],["Option 8", 7]],
		[], 
		"Select which factions can spawn as enemies"
	],

	//
	// PARAM_CATEGORY_WAVE
	//
	[ 
		BULWARK_PARAM_HOSTILE_MULTIPLIER,
		"Base hostiles wave multiplier", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[ ["Reduced", 0.5], ["Normal", 1], ["Double", 2], ["Triple", 3] ], 
		1, 
		"The base number of hostiles generated per wave"
	],
	[ 
		BULWARK_PARAM_HOSTILE_TEAM_MULTIPLIER,
		"Hostiles per player multiplier", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
	    [ ["50%", 50], ["100%", 100], ["150%", 150], ["200%", 200] ],
		0,
		"Additional multiplier on the number of hostiles to add per player"
	],
	[
		BULWARK_PARAM_PISTOL_HOSTILES,
		"Hostiles restricted to pistols until wave", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[["Never", 0], ["1", 1], ["2", 2], ["3", 3], ["5", 5], ["10", 10], ["15", 15], ["20", 20], ["25", 25], ["Always", -1]],
		3,
		"Hostiles will only spawn with pistols until the specified wave"
	],
	[
		BULWARK_PARAM_BODY_CLEANUP,
		"Dead bodies remain for this many waves", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[ ["Until the next round", 0], ["1 round", 1], ["2 rounds", 2] ],
		0,
		"Dead bodies will remain for the specified number of waves. Higher wave numbers can cause reduced performance and increased lag"
	],
	[
		BULWARK_PARAM_DOWN_TIME,
		"Down time between waves", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[ ["No downtime", 0], ["15 seconds", 15], ["30 seconds", 30], ["60 seconds", 60], ["90 seconds", 90], ["2 minutes", 120], ["3 minutes", 180], ["4 minutes", 240], ["5 minutes", 300] ],
		3,
		"There will be this much time between rounds for you to recuperate, build and search"
	],
	[
		BULWARK_PARAM_MAX_WAVES,
		"Maximum number of waves", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[ ["No limit", 0], ["20 waves", 20], ["30 waves", 30], ["40 waves", 40] ],
		0,
		"The game will end after this many waves"
	],
	[
		BULWARK_PARAM_SPECIAL_WAVES,
		"Special waves?", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[["No", 0], ["Yes", 1]],
		1,
		"Should there be special waves, such as suicide bombers, night time, dense fog, etc. after the first few waves?"
	],
	[
		BULWARK_PARAM_SPECIAL_WAVES_ONLY,
		"Only special waves?", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[["No", 0], ["Yes", 1]],
		0,
		"Should there be only be special waves after the first few waves?"
	],
	[
		BULWARK_PARAM_SPECIAL_WAVES_VARIETY,
		"Increase special wave variety?", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[["No", 0], ["Yes", 1]],
		1,
		"Should there be less chance of repeating the same special wave type?"
	],
	[
		BULWARK_PARAM_ARMOUR_START_WAVE,
		"Vehicles may spawn after wave", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[["Never", 0], ["5", 5], ["10", 10], ["15", 15], ["20", 20], ["25", 25]],
		1,
		"Vehicles will start to spawn after the specified wave?"
	],
	[
		BULWARK_PARAM_ARMOUR_WAVE_SCALING,
		"Armor spawn budget", PARAM_CATEGORY_WAVE, PARAM_TYPE_NUMBER, false,
		[["50%", 0.2], ["100%", 0.4], ["150%", 0.6], ["200%", 0.8]],
		1,
		"Controls how much budget is available for spawning vehicles.  Higher means more and more powerful vehicles."
	],

	//
	// PARAM_CATEGORY_START
	//
	[
		BULWARK_PARAM_PLAYER_STARTMAP,
		"Start with a map?", PARAM_CATEGORY_START, PARAM_TYPE_NUMBER, false,
		[ ["No", 0], ["Yes", 1]],
		1,
		"Should players start with a map in their inventory?"
	],
	[
		BULWARK_PARAM_PLAYER_STARTWEAPON,
		"Start with a pistol?", PARAM_CATEGORY_START, PARAM_TYPE_NUMBER, false,
		[ ["No", 0], ["Yes", 1]],
		0,
		"Should players start with a pistol in their inventory?"
	],
	[
		BULWARK_PARAM_PLAYER_STARTNVG,
		"Start with NVGs?", PARAM_CATEGORY_START, PARAM_TYPE_NUMBER, false,
		[ ["No", 0], ["Yes", 1]],
		0,
		"Should players start with NVGs in their inventory?"
	],

	//
	// PARAM_CATEGORY_GAME
	//
	[
		BULWARK_PARAM_RANDOM_WEAPONS,
		"Randomize hostile weapons?", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[ ["No", 0], ["Yes", 1]],
		0,
		"Should enemies have completely randomized weapons?"
	],
	[
		BULWARK_PARAM_HUD_POINT_HITMARKERS,
		"Point hitmarkers on HUD?", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[ ["No", 0], ["Yes", 1]],
		1,
		"Should there be hit markers on the HUD?"
	],
	[
		BULWARK_PARAM_LOOT_HOUSE_DENSITY,
		"Minimum buildings near bulwark", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[ ["5", 5], ["10", 10], ["15", 15], ["20", 20], ["25", 25], ["30", 30]],
		1,
		"The minimum number of buildings which must be near the bulwark to be considered a valid starting location"
	],
	[
		BULWARK_PARAM_LOOT_HOUSE_DISTRIBUTION,
		"Loot distribution", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[ ["Every building", 1], ["Every second building", 2], ["Every third building", 3], ["Every fourth building", 4]],
		1,
		"This determines which buildings will spawn loot"
	],
	[
		BULWARK_PARAM_LOOT_ROOM_DISTRIBUTION,
		"Loot density", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[ ["Every location", 1], ["Every second location", 2], ["Every third location", 3], ["Every fourth location", 4]],
		1,
		"This determines which locations within a building will spawn loot"
	],
	[
		BULWARK_PARAM_LOOT_SUPPLYDROP,
		"Supply drop distance", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[ ["Center", 0], ["Within 25% radius", 25], ["Within 50% radius", 50], ["Within 75% radius", 75]],
		1,
		"This determines how far from the center of the mission area supply crates will drop"
	],
	[
		BULWARK_PARAM_DAY_TIME_FROM,
		"Earliest mission time start", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[ ["0200 hours", 2], ["0400 hours", 4], ["0600 hours", 6], ["0800 hours", 8], ["1000 hours", 10], ["1200 hours", 12], ["1400 hours", 14], ["1600 hours", 16], ["1800 hours", 18], ["2000 hours", 20]],
		3,
		"The earliest time of dat the mission will start"
	],
	[
		BULWARK_PARAM_DAY_TIME_TO,
		"Latest mission time start", PARAM_CATEGORY_GAME, PARAM_TYPE_NUMBER, false,
		[ ["0200 hours", 2], ["0400 hours", 4], ["0600 hours", 6], ["0800 hours", 8], ["1000 hours", 10], ["1200 hours", 12], ["1400 hours", 14], ["1600 hours", 16], ["1800 hours", 18], ["2000 hours", 20]],
		7,
		"The latest time of day the mission will start"
	],

	//
	// PARAM_CATEGORY_GEOGRAPHY
	//
	[
		BULWARK_PARAM_BULWARK_RADIUS,
		"Mission area size", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, false,
		[ ["Tiny (50m)", 50], ["Small (100m)", 100], ["Normal (150m)", 150], ["Large (200m)", 200], ["Huge (250m)", 250] ],
		2,
		"This is the mission area radius be around the start area"
	],
	[
		BULWARK_PARAM_BULWARK_MINSIZE,
		"Minimum spawn room size", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, false,
		[ ["10m²", 10], ["13m²", 13], ["15m²", 15], ["18m²", 18], ["20m²", 20] ],
		1,
		"This is the minimum size the spawn room will be"
	],
	[
		BULWARK_PARAM_LANDRATIO,
		"Minimum land/water ratio", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, false,
		[ ["60%", 60], ["70%", 70], ["80%", 80], ["90%", 90], ["100%", 100] ],
		2,
		"This is the minimum ratio of land to water, to avoid spawning on a dock of pier"
	],
	[
		BULWARK_PARAM_BULWARK_POSITION,
		"Starting position", PARAM_CATEGORY_GEOGRAPHY, PARAM_TYPE_NUMBER, false,
		[ ["Near a town", 0], ["Random marker", 1] ],
		0,
		"Determines whether the start area will be chosen at random or from among a selection of pre-defined marked locations for this map"
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
		[["No", 0], ["Yes", 1]],
		1,
		"Do upgrades require the Satellite dish to have been found?"
	],
	[
		BULWARK_PARAM_KILLPOINTS_MODE,
		"How kill points are distributed", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[["Personal", KILLPOINTS_MODE_PRIVATE], ["Shared", KILLPOINTS_MODE_SHARED], ["Shareable", KILLPOINTS_MODE_SHAREABLE]],
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
		[ ["10", 10], ["50", 50], ["100", 100], ["200", 200], ["300, 300"]],
		2,
		"The number of points awarded for each confirmed kill"
	],
	[
		BULWARK_PARAM_SCORE_HIT,
		"Points per hit", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[["0", 0], ["10", 10], ["20", 20], ["50", 50], ["100", 100]],
		2,
		"The number of bonus points awarded for each hit"
	],
	[
		BULWARK_PARAM_SCORE_DAMAGE_BASE,
		"Damage bonus points", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[["0", 0], ["10", 10], ["20", 20], ["50", 50], ["100", 100]],
		2,
		"The number of bonus points awarded for extra damage"
	],
	[
		BULWARK_PARAM_PARATROOP_COUNT,
		"Paratrooper count", PARAM_CATEGORY_UPGRADES, PARAM_TYPE_NUMBER, false,
		[["1", 1], ["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6]],
		2,
		"The number of paratroopers dropped when called"
	],

	//
	// PARAM_CATEGORY_PLAYER
	//
	[
		BULWARK_PARAM_REVIVE_ITEMS,
		"Revive required items", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[ ["None", 0], ["Medikit", 1], ["FAK or Medikit", 2]],
		2,
		"The items which are required to revive another player"
		// TODO 	function = "bis_fnc_paramReviveRequiredItems";
	],
	[
		BULWARK_PARAM_RESPAWN_TICKETS,
		"Respawn tickets", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[ ["0", 0], ["5", 5], ["10", 10], ["15", 15], ["20", 20]],
		0,
		"The number of respawn tickets"
	],
	[
		BULWARK_PARAM_RESPAWN_TIME,
		"Respawn time", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[ ["Instant", 0], ["5 seconds", 5], ["10 seconds", 10], ["20 seconds", 20], ["30 seconds", 30]],
		2,
		"The amount of time after using a ticket before the player respawns"
	],
	[
		BULWARK_PARAM_TEAM_DAMAGE,
		"Enable friendly fire?", PARAM_CATEGORY_PLAYER, PARAM_TYPE_NUMBER, false,
		[ ["No", 0], ["Yes", 1] ],
		1,
		"Whether or not friendly-fire is enabled"
	]

];

	// TODO
	// class FILTER_PRESET
	// {
	// 	values[] = {0,1,2,3,4};
	// 	texts[] = {"Normal","WW2 (IFA3_AIO_LITE)","Global Mobilization","WW2 Winter (IFA_AIO_LITE)","Custom (same as Normal by default, its for you to mess around in)"};
	// 	default = 0;
	// };

_defaultBulwarkParams;
