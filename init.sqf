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


//Create spawnpoint
bulMkr = createMarker ["respawn_west", bulwarkRoomPos];
bulMkr setMarkerShape "ICON";
bulMkr setMarkerType "hd_dot";
bulMkr setMarkerColor "ColorBlue";
bulMkr setMarkerText "Spawn";

publicVariable "bullwarkBox";

if (isServer) then {
	{
		_newLoc = [bullwarkBox] call bulwark_fnc_findPlaceAround;
		_x setPosASL _newLoc;
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
};

//Set time of day
if (isServer) then {
	_dayTimeHours = DAYTIMETO - DAYTIMEFROM;
	_randTime = floor random _dayTimeHours;
	_timeToSet = DAYTIMEFROM + _randTime;
	setDate [2018, 7, 1, _timeToSet, 0];
};

if (isServer) then {
	["", "BLACK IN", 2] remoteExec ["titleText", -2];
	[bulwarkRoomPos] execVM "missionLoop.sqf";
};
