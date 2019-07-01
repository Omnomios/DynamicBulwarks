
//teleport players away from Bulwark
{
    _distToBulwark = 0;
    _distFromBulwark = "BULWARK_RADIUS" call BIS_fnc_getParamValue;
    telePos = getPos _x;
    while {_distToBulwark < 30 && {["mine_", str(_x)] call BIS_fnc_inString} count (telePos nearObjects 10) <= 1} do {
    telePos = [bulwarkRoomPos, 30, _distFromBulwark - 10, 3, 0, 10, 0] call BIS_fnc_findSafePos;
    _distToBulwark = telePos distance bulwarkBox;
    };
    if (telePos distance _x >= 3 && _x distance bulwarkBox < 30) then {
    _x setPos telePos;
    };
    telePos = [];
} forEach allPlayers;


//Spawn AI Around Bulwark
for ("_i") from 1 to ((floor attkWave / 2) + (floor count allPlayers * 1.5)) do {
    _location = [bulwarkBox] call bulwark_fnc_findPlaceAround;
    _attGroupBand = createGroup [EAST, true];
    _unitClass = selectRandom HOSTILE_LEVEL_1;
    _unit = objNull;
    _unit = _attGroupBand createUnit [_unitClass, [0,0,0], [], 0.5, "FORM"];
    _unit setPosASL _location;
	sleep 0.3;
	waitUntil {!isNull _unit};

	[_unit] join _attGroupBand;
	_unit setSkill ["aimingAccuracy", 0.05];
	_unit setSkill ["aimingSpeed", 0.05];
	_unit setSkill ["aimingShake", 0.05];
	_unit setSkill ["spotTime", 0.05];
	_unit addEventHandler ["Hit", killPoints_fnc_hit];
	_unit addEventHandler ["Killed", killPoints_fnc_killed];
    _unit setVariable ["killPointMulti", HOSTILE_LEVEL_1_POINT_SCORE];
	removeAllAssignedItems _unit;
	mainZeus addCuratorEditableObjects [[_unit], true];
    unitArray = waveUnits select 0;
    unitArray append [_unit];
};
