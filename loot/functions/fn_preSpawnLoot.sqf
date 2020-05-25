/**
*  preSpawnLoot
*
*  Spawns loot randomly around the play area
*
*  Domain: Server
**/

// NOTE: This function should only be called by startPreSpawn, to ensure the spawn task handle is captured
//       so that revealPreSpawnedLoot can wait on it if necessary

["BEGIN Loot PreInit", "LOOT"] call shared_fnc_log;
preInitLoot = [];

call loot_fnc_randomizeLootRoomIndices;

//activeLoot = [];
lootDebugMarkers = [];

private _item = call loot_fnc_trySpawnLootReveal;
if(!isNil "_item") then {
	preInitLoot pushBack _item;
};

_item = call loot_fnc_trySpawnKillPoints;
if(!isNil "_item") then {
	preInitLoot pushBack _item;
};

// Support has its own reveal and cleanup policy so we don't add it to the preinit list here
call loot_fnc_trySpawnSupport;

["Spawning items", "LOOT"] call shared_fnc_log;
DBW_selectWeapon = {
	params["_type"];
	_type = toUpper _type;
	_typeString = format ["LOOT_WEAPON_%1_POOL",_type];
	_pool = call compile _typeString;
	_weapon = selectRandom _pool;
	_weapon
};

private _lootHolder = 0;
while { _lootHolder = call loot_fnc_trySpawnLootItem; !isNil "_lootHolder" } do {
	preInitLoot pushBack _lootHolder;
};


["END Loot PreInit", "LOOT"] call shared_fnc_log;
/* Supply Drop */
[bulwarkCity, ["<t color='#00ff00'>" + "FILL AMMO", "supports\ammoDrop.sqf","",2,true,false,"true","true",4], supportAircraft] remoteExec ["supports_fnc_supplyDrop", 2];

