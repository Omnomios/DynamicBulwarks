_locations = _this select 0;
_radius = _this select 1;

_finalPos = nil;
_finalCity = nil;

_probe = createVehicle ["Sign_Arrow_F", [0,0,0], [], 0, "CAN_COLLIDE"];
while {isNil "_finalPos"} do {
	_city = selectRandom _locations;
	_houses = nearestObjects [_city, ["house"], 300];

	_options = [];

	// Go through every house and position
	{
		_house = _x;
		_largestVolume = 0;
		_largestPos = [0,0,0];

		// Go through the positions in the house to find the largest
		{
			_probe setPos _x;
			_roomVolume = [_probe, getDir _house] call bulwark_fnc_roomVolume;
			if(_roomVolume select 0) then {
				if((_roomVolume select 1 > _largestVolume) && (_roomVolume select 1 > BULWARK_MINSIZE)) then {
					_roomCentre = [_probe, getDir _house] call bulwark_fnc_roomCentre;
					_largestPos = _roomCentre select 1;
					_largestVolume = (_largestVolume max (_roomVolume select 1));
				};
			};
		} forEach (_house buildingPos -1);

		// Make sure it's not some crapshack in the middle of nowhere
		_neighbours = count nearestObjects [_largestPos, ["house"], BULWARK_RADIUS];

		// One house, one location. Add it to the list of options
		if(_largestVolume > 0 && _neighbours > LOOT_HOUSE_DENSITY) then {
			// See how much water is around
			_water = 0;
			_land = 0;
			for ("_i") from 1 to BULWARK_RADIUS / 10 do {
				for ("_a") from 0 to 15 do {
					_relPos = [_largestPos, _i * 10, 22 * _a] call BIS_fnc_relPos;
					if(surfaceIsWater _relPos) then {_water = _water + 1;} else {_land = _land + 1;};
				};
			};
			_totalSurface = _water + _land;
			_landPercent = (_land / _totalSurface) * 100;

			if(_landPercent > BULWARK_LANDRATIO) then {
				_options append [_largestPos];
			};
		};

	} forEach _houses;

	if(count _options > 0) exitWith {
		_finalPos = selectRandom _options;
		_finalCity = _finalPos;
	};
};
deleteVehicle _probe;

[_finalPos, _finalCity];
