
//teleport players away from Bulwark
{
  _distToBulwark = 0;
  _distFromBulwark = "BULWARK_RADIUS" call BIS_fnc_getParamValue;
  while {_distToBulwark < 25} do {
    telePos = [bulwarkRoomPos, _distFromBulwark / 2 - 10, _distFromBulwark / 2 + 10, 3, 0, 10, 0] call BIS_fnc_findSafePos;
    _distToBulwark = telePos distance bulwarkBox;
  };
  _x setPos telePos;
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
	removeAllAssignedItems _unit;

	mainZeus addCuratorEditableObjects [[_unit], true];

  unitArray = waveUnits select 0;
  unitArray append [_unit];
};
