_locations = _this select 0;
_radius = _this select 1;

_finalPos = nil;
_finalCity = nil;

_probe = createVehicle ["Sign_Arrow_F", [0,0,0], [], 0, "CAN_COLLIDE"];
while {isNil "_finalPos"} do {
	_city = selectRandom _locations;
	_houses = nearestObjects [_city, ["house"], _radius];

	_largestVolume = 0;
	_largestPos = [0,0,0];

	// Go through every house and position
	{
		_house = _x;
		{
			_probe setPos _x;
			_roomVolume = [_probe, getDir _house] call bulwark_fnc_roomVolume;
			if(_roomVolume select 0) then {
				if(_largestVolume < _roomVolume select 1) then {
					_roomCentre = [_probe, getDir _house] call bulwark_fnc_roomCentre;
					_largestPos = _roomCentre select 1;
				};
				_largestVolume = (_largestVolume max (_roomVolume select 1));
			};
		} forEach (_house buildingPos -1);
	} forEach _houses;

	if(_largestVolume > 0) exitWith {
		_finalPos = _largestPos;
		_finalCity = _city;
	};
};
deleteVehicle _probe;

[_finalPos, _finalCity];
