if (isServer) then {
	["Preparing mission", "BLACK", 2] remoteExec ["titleText", -2]};
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
	_basepoint = [] execVM "bulwark\createBase.sqf";
	waitUntil { scriptDone _basepoint };
};

// Create const that points to mission folder
MISSION_ROOT = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };


spawnPlaceAround = {
	_spawnObject = _this select 0;
	for ("_i") from 0 to 7 do {
		_relPos = [getPosASL _spawnObject, 2, 45 * _i] call BIS_fnc_relPos;
		if(!lineIntersects [ getPosASL _spawnObject, _relPos, _spawnObject]) exitWith {_relPos};
	};
};
//Create spawnpoint
bulMkr = createMarker ["respawn_west", [bullwarkBox] call spawnPlaceAround];
bulMkr setMarkerShape "ICON";
bulMkr setMarkerType "hd_dot";
bulMkr setMarkerColor "ColorBlue";
bulMkr setMarkerText "Spawn";

if (isServer) then {
	{
		setDate [2018, 1, 1, random [DAYTIMEFROM,DAYTIMETO], 0];
};

if (!isServer && (player != player)) then {
	waitUntil {player == player};
	waitUntil {time > 10};
};

if (isServer) then {
	{
		_newLoc = [bullwarkBox] call spawnPlaceAround;
		_x setPosASL _newLoc vectorAdd [0, 0, 0.15];
	} forEach allPlayers;  //move any players that spawned already to respawn point
};

//Remove stamina and lower sway and recoil
if (!isDedicated) then {
	player setCustomAimCoef 0.2;
	player enableStamina FALSE;
	player addEventHandler ['Respawn',{player enableStamina FALSE;}];
	player addEventHandler ['Respawn',{player setCustomAimCoef 0.2;}];
	player addEventHandler ['Respawn',{player setUnitRecoilCoefficient 0.5;}];
};

if (isServer) then {
	["", "BLACK IN", 2] remoteExec ["titleText", -2];
	[bulwarkCity] execVM "missionLoop.sqf";
};
