_CfgMagazines = configFile >> "CfgMagazines";
_totalentriesMag = count _CfgMagazines;

_CfgVehicles = configfile >> "CfgVehicles";
_totalentriesVec = count _CfgVehicles;

_CfgWeapons = configFile >> "CfgWeapons";
_totalentriesWep = count _CfgWeapons;

activeLoot = [];

// Lootbox
_randCityLocation = [(bulwarkCity select 0) + (random [-100, 0, 100]),(bulwarkCity select 1) + (random [-100, 0, 100]), 0];
_lootBulding = nearestBuilding _randCityLocation;
_lootRooms = _lootBulding buildingPos -1;
_lootBoxRoom = selectRandom _lootRooms;

_lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 0, "CAN_COLLIDE"];
_lootBox enableSimulationGlobal false;
_lootBox addAction [
    "<t color='#FF0000'>Spin the box!</t>", {
        // Call lootspin script only on the server, from the client
        [[_lootBox], "loot/lootspin.sqf"] remoteExec ["BIS_fnc_execVM", 0];
    }
];
publicVariable "_lootBox";
activeLoot pushback _lootBox; //add lootbox to cleanup array

for "_i" from 1 to 60 do { //change to from 1 to wave multiplier
	_lootRoomPos = nil;

	//find room to spawn loot
	while {isNil "_lootRoomPos"} do {
		_randCityLocation = [(bulwarkCity select 0) + (random [-100, 0, 100]),(bulwarkCity select 1) + (random [-100, 0, 100]), 0];
		_lootBulding = nearestBuilding _randCityLocation;
		_lootRooms = _lootBulding buildingPos -1;
		_lootRoomPos = selectRandom _lootRooms;
	};
	_lootHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;

	//determine type of loot to spawn
	_lootToSpawn = floor random 2;

	if (_lootToSpawn == 0) then {	//spawn weapon
		_scope = 0;
		while {true} do {
			_checkedWep = _CfgWeapons select round (random _totalentriesWep);
			_scope = getNumber (_checkedWep >> "scope");
			sleep 1;
			if (_scope != 0) exitWith {wepClassname = configName _checkedWep};
		};
		if (wepClassname isKindOf ["ItemCore", configFile >> "cfgWeapons"]) then {
			_lootHolder addItemCargoGlobal [wepClassname, 1];
        } else {
			_lootHolder addWeaponCargoGlobal [wepClassname, 1];
		};
	};

	if (_lootToSpawn == 1) then {	//spawn Mag
		while {true} do {
			_lootFound = nil;
			_checkedMag = _CfgMagazines select round (random _totalentriesMag);
			_classname = configName _checkedMag;
			if (_classname isKindOf ["VehicleMagazine", configFile >> "cfgMagazines"]) then {
				_lootFound = false;
			} else {
				_lootFound = true;
			};
			if (_lootFound) exitWith {
				_lootHolder addMagazineCargoGlobal [_classname, 1];
			};
		};
	};
	_lootHolder setPos [_lootRoomPos select 0, _lootRoomPos select 1, (_lootRoomPos select 2) + 0.1];

	activeLoot pushback _lootHolder; // Add object to array for later cleanup

	//spawn packpack - Not really working
	_spwnBackPack = floor random 3;
	if (_spwnBackPack == 1) then {
		while {true} do {
			_lootFound = false;
			_checkedBPack = _CfgVehicles select round (random _totalentriesVec);
			_classname = configName _checkedBPack;
			if (_classname isKindOf ["Bag_Base", configFile >> "CfgVehicles"]) then {
				_lootFound = true;
			};
			if (_lootFound) exitWith {
				_bagHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;
				_bagHolder addItemCargoGlobal [_classname, 1];
				activeLoot pushback _lootHolder;
				hint "Bag found";
				sleep 0.1;
			};
		};
	};
};
