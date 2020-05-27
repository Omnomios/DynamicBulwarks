// These are the stored parameter IDs, and should be named BULWARK_PARAM_<param name>
// * They do NOT necessarily correspond to the parameter index in the array
// * They are opaque identifiers
// * The name of the ID does not matter, but you should follow the convention above
// * WARNING: Do not reorder or reuse ID numbers
#define BULWARK_PARAM_FILTER_DLC                0
#define BULWARK_PARAM_HOSTILE_MULTIPLIER        1
#define BULWARK_PARAM_HOSTILE_TEAM_MULTIPLIER   2
#define BULWARK_PARAM_PISTOL_HOSTILES           3
#define BULWARK_PARAM_BODY_CLEANUP              4
#define BULWARK_PARAM_DOWN_TIME                 5
#define BULWARK_PARAM_MAX_WAVES                 6
#define BULWARK_PARAM_SPECIAL_WAVES_ONLY        7
#define BULWARK_PARAM_SPECIAL_WAVES_VARIETY     8
#define BULWARK_PARAM_ARMOUR_START_WAVE         9
#define BULWARK_PARAM_PLAYER_STARTMAP           10
#define BULWARK_PARAM_PLAYER_STARTWEAPON        11
#define BULWARK_PARAM_PLAYER_STARTNVG           12
#define BULWARK_PARAM_RANDOM_WEAPONS            13
#define BULWARK_PARAM_HUD_POINT_HITMARKERS      14
#define BULWARK_PARAM_LOOT_HOUSE_DENSITY        15
#define BULWARK_PARAM_LOOT_HOUSE_DISTRIBUTION   16
#define BULWARK_PARAM_LOOT_ROOM_DISTRIBUTION    17
#define BULWARK_PARAM_LOOT_SUPPLYDROP           18
#define BULWARK_PARAM_DAY_TIME_FROM             19
#define BULWARK_PARAM_DAY_TIME_TO               20
#define BULWARK_PARAM_BULWARK_RADIUS            21
#define BULWARK_PARAM_BULWARK_MINSIZE           22
#define BULWARK_PARAM_LANDRATIO                 23
#define BULWARK_PARAM_BULWARK_POSITION          24
#define BULWARK_PARAM_BULWARK_MEDIKIT           25
#define BULWARK_PARAM_SUPPORT_MENU              26
#define BULWARK_PARAM_START_KILLPOINTS          27
#define BULWARK_PARAM_SCORE_KILL                28
#define BULWARK_PARAM_SCORE_HIT                 29
#define BULWARK_PARAM_SCORE_DAMAGE_BASE         30
#define BULWARK_PARAM_PARATROOP_COUNT           31
#define BULWARK_PARAM_REVIVE_ITEMS              32
#define BULWARK_PARAM_RESPAWN_TICKETS           33
#define BULWARK_PARAM_RESPAWN_TIME              34
#define BULWARK_PARAM_TEAM_DAMAGE               35
#define BULWARK_PARAM_SPECIAL_WAVES             36
#define BULWARK_PARAM_FILTER_PRESET             37
#define BULWARK_PARAM_ARMOUR_WAVE_SCALING       38
#define BULWARK_PARAM_KILLPOINTS_MODE           39
#define BULWARK_PARAM_FILTER_FACTIONS           40
#define BULWARK_PARAM_TIME_MULTIPLIER           41
#define BULWARK_PARAM_SEASON                    42
#define BULWARK_PARAM_LOCATIONS                 43
#define BULWARK_PARAM_LOOT_WEAPONS              44
#define BULWARK_PARAM_LOOT_WORN                 45
#define BULWARK_PARAM_LOOT_ATTACHMENTS          46
#define BULWARK_PARAM_LOOT_EXPLOSIVES           47
#define BULWARK_PARAM_LOOT_CONSTRUCTS           48

// These are known parameter values, and should be named <param name>_<value name>
// WARNING: If you change these it could mess up the interpretation of people's saved parameters.
// If you need to get rid of a value, you should instead rename it and interpret the old
// value as one of the new values (so old saves keep working).
#define KILLPOINTS_MODE_PRIVATE    0  // Killpoints are per-player
#define KILLPOINTS_MODE_SHARED     1  // Killpoints are shared by all players
#define KILLPOINTS_MODE_SHAREABLE  2  // Killpoint can be shared by players manually

#define LOOT_CATEGORY_HATS					0
#define LOOT_CATEGORY_UNIFORMS				1
#define LOOT_CATEGORY_VESTS					2
#define LOOT_CATEGORY_BACKPACKS				3
#define LOOT_CATEGORY_STATIC_GUNS			4
#define LOOT_CATEGORY_DRONE_GUNS			5
#define LOOT_CATEGORY_DRONES				6
#define LOOT_CATEGORY_LAUNCHERS				7
#define LOOT_CATEGORY_OPTICS				8
#define LOOT_CATEGORY_RAIL_ATTACHMENTS		9
#define LOOT_CATEGORY_MUZZLE_ATTACHMENTS	10
#define LOOT_CATEGORY_BIPODS				11
#define LOOT_CATEGORY_MISC					12
#define LOOT_CATEGORY_MINES					13
#define LOOT_CATEGORY_GLASSES				14
#define LOOT_CATEGORY_GRENADES				15
#define LOOT_CATEGORY_EXPLOSIVES			16
#define LOOT_CATEGORY_SNIPER				17
#define LOOT_CATEGORY_ASSAULT				18
#define LOOT_CATEGORY_SMG					19
#define LOOT_CATEGORY_MG					20
#define LOOT_CATEGORY_NVGS					21
#define LOOT_CATEGORY_HANDGUNS				22