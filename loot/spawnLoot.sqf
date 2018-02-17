_CfgMagazines = configFile >> "CfgMagazines";
_totalentriesMag = count _CfgMagazines;

_CfgVehicles = configfile >> "CfgVehicles";
_totalentriesVec = count _CfgVehicles;

activeLoot = [];

// Lootbox
_randCityLocation = [(bulwarkCity select 0) + (random [-100, 0, 100]),(bulwarkCity select 1) + (random [-100, 0, 100]), 0];
_lootBulding = nearestBuilding _randCityLocation;
_lootRooms = _lootBulding buildingPos -1;
_lootBoxRoom = selectRandom _lootRooms;

//Item to reveal hostiles on Map (1 spawns every wave)
_randCityLocation = [(bulwarkCity select 0) + (random [-125, 0, 125]),(bulwarkCity select 1) + (random [-125, 0, 125]), 0];
_lootBulding = nearestBuilding _randCityLocation;
_lootRooms = _lootBulding buildingPos -1;
_droneRoom = selectRandom _lootRooms;
_droneSupport = createVehicle ["Box_C_UAV_06_Swifd_F", _droneRoom, [], 0, "CAN_COLLIDE"];
_droneSupport addAction ["Reveal enemies", "supports\reconDrone.sqf"];

//add loot items to cleanup array
activeLoot pushback _droneSupport;

systemChat "Started loot spawn";

{
	_lootBulding = _x;
	_lootRooms = _lootBulding buildingPos -1;

	{
		_lootRoomPos = _x;
		_lootHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;

		//determine type of loot to spawn
		_lootToSpawn = floor random 4;

		if (_lootToSpawn == 0) then {
			_weapon = selectRandom List_AllWeapons;
			_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 3];
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
		};

		if (_lootToSpawn == 1) then {	//spawn Mag
			_weapon = selectRandom List_AllWeapons;
			_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 2];
		};

		if (_lootToSpawn == 2) then {	//spawn Mag
			_clothes = selectRandom List_AllClothes;
			_lootHolder addWeaponCargoGlobal [_clothes, 1];
		};

		if (_lootToSpawn == 3) then {	//spawn Mag
			_backpack = selectRandom List_AllStorage;
			_lootHolder addWeaponCargoGlobal [_backpack, 1];
		};

		_lootHolder setPos [_lootRoomPos select 0, _lootRoomPos select 1, (_lootRoomPos select 2) + 0.1];

		activeLoot pushback _lootHolder; // Add object to array for later cleanup

	} forEach _lootRooms;

} forEach lootHouses;

systemChat "Loot spawn complete";

/*
for "_i" from 1 to 60 do { //change to from 1 to wave multiplier
	_lootRoomPos = nil;

	//find room to spawn loot
	while {isNil "_lootRoomPos"} do {
		_randCityLocation = [(bulwarkCity select 0) + (random [-125, 0, 125]),(bulwarkCity select 1) + (random [-125, 0, 125]), 0];
		_lootBulding = nearestBuilding _randCityLocation;
		_lootRooms = _lootBulding buildingPos -1;
		_lootRoomPos = selectRandom _lootRooms;
	};
	_lootHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;

	//determine type of loot to spawn
	_lootToSpawn = floor random 2;

	if (_lootToSpawn == 0) then {
		_weapon = selectRandom List_AllWeapons;
		_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
		_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 3];
		_lootHolder addWeaponCargoGlobal [_weapon, 1];
	};

	if (_lootToSpawn == 1) then {	//spawn Mag
		_weapon = selectRandom List_AllWeapons;
		_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
		_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 2];
	};
	_lootHolder setPos [_lootRoomPos select 0, _lootRoomPos select 1, (_lootRoomPos select 2) + 0.1];

	activeLoot pushback _lootHolder; // Add object to array for later cleanup

	//spawn packpack
	_spwnBackPack = floor random 10;
	if (_spwnBackPack == 1) then {
		while {true} do {
			_lootBag = objNull;
			_lootFound = false;
			_checkedBPack = _CfgVehicles select round (random _totalentriesVec);
			_classname = configName _checkedBPack;
			if (_classname isKindOf ["Bag_Base", configFile >> "CfgVehicles"]) then {
				_lootFound = true;
			};
			if (_lootFound) exitWith {
				//_bagHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;
				//_bagHolder addItemCargoGlobal [_classname, 1];
				_lootBagRoomPos = selectRandom _lootRooms;
				_lootBag = _classname createVehicle _lootBagRoomPos;
				activeLoot pushback _lootBag;
			};
		};
	};
};
*/

[[(bulwarkCity select 0) - 1000,(bulwarkCity select 1) - 1000,200],[(bulwarkCity select 0) + 1000,(bulwarkCity select 1) + 1000,200],200,"NORMAL","B_T_VTOL_01_vehicle_F",WEST] call BIS_fnc_ambientFlyby;
sleep 10;
_playerCount = count playableUnits;
_parachute = "B_Parachute_02_F" CreateVehicle [0,0,0];
_parachute setPos [((bulwarkCity select 0) + (random [-125, 125, 0])),((bulwarkCity select 1) + (random [-125, 125, 0])),150];
_ammoBox = createVehicle ["Cargonet_01_box_F", [0,0,0], [], 0, "CAN_COLLIDE"];
//_ammoBox addAction ["FILL AMMO", "supports\ammoDrop.sqf"];
[_ammoBox, ["FILL AMMO", "supports\ammoDrop.sqf"]] remoteExec ["addAction", 0];
_ammoBox attachTo [_parachute,[0,0,0]];
_ammoBox allowDamage false;
waitUntil {getpos _ammoBox select 2<4};
detach _ammoBox;
