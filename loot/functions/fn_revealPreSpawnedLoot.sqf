waitUntil { scriptDone preSpawnHandle };

["BEGIN Loot reveal", "LOOT"] call shared_fnc_log;
{
    _x hideObjectGlobal false;
    _x enableSimulationGlobal true;
    lootObjects pushBack _x;
} forEach preInitLoot;

preInitLoot = [];

["END Loot reveal", "LOOT"] call shared_fnc_log;