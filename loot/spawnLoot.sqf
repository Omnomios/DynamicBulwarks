//_gunToSpawn = ["arifle_MX_F", "arifle_MX_GL_F", "arifle_MXC_F", "arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F", "arifle_MXM_F", "LMG_Mk200_F", "hgun_P07_F", "hgun_rook40_F"];
//_ammoToSpawn = ["30Rnd_65x39_Caseless_mag", "100Rnd_65x39_Caseless_mag", "30Rnd_65x39_caseless_mag_Tracer", "100Rnd_65x39_caseless_mag_Tracer", "16Rnd_9x21_Mag", "30Rnd_9x21_Mag", "20Rnd_556x45_UW_Mag", "30RND_556x45_Stanag", "200RND_65x39_Cased_box_Tracer", "RPG32_F", "ATMine_Range_Mag",  "APERSTripMine_Wire_Mag", "1Rnd_HE_Grenade_shell", "1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell", "1Rnd_SmokeYellow_Grenade_shell", "1Rnd_SmokePurple_Grenade_shell", "1Rnd_SmokeBlue_Grenade_shell", "1Rnd_SmokeOrange_Grenade_shell", "SmokeShellRed", "SmokeShell", "SmokeShellGreen", "SmokeShellYellow", "SmokeShellPurple", "SmokeShellBlue", "SmokeShellOrange"];
//_itemToSpawn = ["muzzle_snds_H", "muzzle_snds_L", "muzzle_snds_B", "muzzle_snds_H_MG", "optic_Arco", "optic_Hamr", "optic_Aco", "optic_ACO_grn", "optic_Holosight", "acc_flashlight", "acc_pointer_IR", "FirstAidKit", "Toolkit"];

_CfgMagazines = configFile >> "CfgMagazines";
_totalentriesMag = count _CfgMagazines;

_CfgVehicles = configfile >> "CfgVehicles";
_totalentriesVec = count _CfgVehicles;

_CfgWeapons = configFile >> "CfgWeapons";
_totalentriesWep = count _CfgWeapons;



activeLoot = [];

for "_i" from 1 to 60 do { //change to from 1 to wave multiplier
	//find room to spawn loot
	_lootRoomPos = nil;
	while {isNil "_lootRoomPos"} do {
		_randCityLocation = [(bulwarkCity select 0) + (random [-100, 0, 100]),(bulwarkCity select 1) + (random [-100, 0, 100]), 0];
		_lootBulding = nearestBuilding _randCityLocation;
		_lootRooms = _lootBulding buildingPos -1;
		_lootRoomPos = selectRandom _lootRooms;
	};	
	_lootHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;
	//determine type of loot to spawn
	_lootToSpawn = floor random 2;
	if (_lootToSpawn == 0) then { //spawn weapon 
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
	if (_lootToSpawn == 1) then {//spawn Mag
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
	//if (_lootToSpawn == 3) then {
	//	_lootHolder addItemCargoGlobal [selectRandom _itemToSpawn,1];
	//};
	_lootHolder setPos [_lootRoomPos select 0, _lootRoomPos select 1, (_lootRoomPos select 2) + 0.1];
	activeLoot pushback _lootHolder;
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