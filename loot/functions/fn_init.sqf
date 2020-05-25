
["BEGIN Loot init", "LOOT"] call shared_fnc_log;

lootObjects = [];
preInitLoot = [];

// Candidate houses must be within the radius and have at least one room
private _bulwarkLocation = [bulwarkCity select 0, bulwarkCity select 1, 0];
lootHouses = (_bulwarkLocation nearObjects ["Building", BULWARK_RADIUS]) select { count (_x buildingPos -1) > 0 };

// Precalculate all of the possible places loot can be places
possibleLootRooms = []; // This holds the room locations
lootRoomIndices = [];   // This holds the randomized list of loot room indices

{
    if (_forEachIndex mod LOOT_HOUSE_DISTRIBUTION == 0) then {
        private _lootRooms = _x buildingPos -1;
        {
            if (_forEachIndex mod LOOT_ROOM_DISTRIBUTION == 0) then {
                lootRoomIndices pushBack (count lootRoomIndices);
                possibleLootRooms pushBack _x;
            }
        }
        forEach _lootRooms;
    };
}
forEach lootHouses;

call loot_fnc_randomizeLootRoomIndices;
call loot_fnc_trySpawnLootSpinner;

["END Loot init", "LOOT"] call shared_fnc_log;