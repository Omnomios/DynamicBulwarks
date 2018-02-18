/* Attacker Waves */

// List_Bandits, List_ParaBandits, List_OPFOR, List_INDEP, List_NATO, List_Viper

HOSTILE_LEVEL_1 = List_Bandits;         // Wave 0 >
HOSTILE_LEVEL_2 = List_ParaBandits;     // Wave 5 >
HOSTILE_LEVEL_3 = List_Viper;           // Wave 10 >
HOSTILE_MULTIPLIER = 1.2;

// List_LocationMarkers, List_AllCities
BULWARK_LOCATIONS = List_LocationMarkers;
BULWARK_RADIUS = 150;
BULWARK_MINROOMS = 5;   // Spawn room must have this many locations to be valid

/* Loot Spawn */
LOOT_WEAPON_POOL  = List_AllWeapons;    // Classnames of Loot items as an array
LOOT_APPAREL_POOL = List_AllClothes;
LOOT_ITEM_POOL    = List_Optics;
LOOT_STORAGE_POOL = List_AllStorage;

/* Random Loot */
LOOT_HOUSE_DISTRIBUTION = 2;  // Every *th house will spwan loot.
LOOT_ROOM_DISTRIBUTION = 3;   // Every *th position, within that house will spawn loot.
LOOT_DISTRIBUTION_OFFSET = 0; // Offset the position by this number.
LOOT_DEBUG = FALSE;           // Shows loot as markers on the map
LOOT_SUPPLYDROP = 0.2;        // Radius of supply drop
PARATROOP_COUNT = 3;
PARATROOP_CLASS = List_INDEP;

/* Points */
SCORE_KILL = 100;       // Every kill
SCORE_HIT = 10;         // Every Bullet hit that doesn't result in a kill
SCORE_DAMAGE_BASE = 10; // Extra points awarded for damage. 100% = SCORE_DAMAGE_BASE. 50% = SCORE_DAMAGE_BASE/2
SCORE_RANDOMBOX = 950;  // Cost to spin the box
SCORE_AMMOBOX = 500;    // Cost to reload at an ammo box
SCORE_FIRSTAID = 250;   // Cost per FAK
SCORE_RECONUAV = 800;   // Show units on map
SCORE_PARATROOP = 1450; // Paratroopers
SCORE_AIRSTRIKE = 5430; // CAS Missles
