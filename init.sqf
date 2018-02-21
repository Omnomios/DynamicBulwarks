titleText ["Preparing mission", "BLACK FADED", 0];
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

if (isServer) then {
	{
		_newLoc = (getPos bullwarkBox) findEmptyPosition [1, 10];
		_x setPos _newLoc;
	} forEach allPlayers;  //move any players that spawned already to respawn point
};

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
	player addEventHandler ['Respawn',{player setUnitRecoilCoefficient 0.5;}];

	player addAction ['Break Medikit', {
	    player removeItem "Medikit";
	    for ("_i") from 1 to 4 do { player addItem "firstAidKit"; };
	}, nil, 1.5, true, true, '', "'Medikit' in items _this"];
};

titleText ["", "BLACK IN", 2];
if (isServer) then {
	[bulwarkCity] execVM "missionLoop.sqf";
};
