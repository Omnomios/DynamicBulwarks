_handle = [] execVM "locationLists.sqf";
waitUntil {scriptDone _handle};
_handle = [] execVM "loot\lists.sqf";
waitUntil {scriptDone _handle};
_handle = [] execVM "hostiles\lists.sqf";
waitUntil {scriptDone _handle};
_handle = [] execVM "editMe.sqf";
waitUntil {scriptDone _handle};

//Select City and spawn point
if (isServer) then {
	_basepoint = [] execVM "createBase.sqf";
	waitUntil { scriptDone _basepoint };
};

// Create const that points to mission folder
MISSION_ROOT = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };

//Create spawnpoint
bulMkr = createMarker ["respawn_west", BulwarkRoomPos];
bulMkr setMarkerShape "ICON";
bulMkr setMarkerType "hd_dot";
bulMkr setMarkerColor "ColorBlue";
bulMkr setMarkerText "Spawn";

{
	_newLoc = [getMarkerPos bulMkr, 0, 10, 1, 0] call BIS_fnc_findSafePos;
	_x setpos _newLoc;
} forEach allPlayers;  //move any players that spawned already to respawn point

if (!isServer && (player != player)) then {
	waitUntil {player == player};
	waitUntil {time > 10};
};

//Remove stamina and lower sway and recoil
if (!isDedicated) then {
     player setCustomAimCoef 0.2;
     player enableStamina FALSE;
     player addEventHandler ['Respawn',{player enableStamina FALSE;}];
     player addEventHandler ['Respawn',{player setCustomAimCoef 0.2;}];
     player addEventHandler ['Respawn',{player setUnitRecoilCoefficient .5;}];
};

if (isServer) then {
	[bulwarkCity] execVM "missionLoop.sqf";
};
