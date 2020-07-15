#include "..\..\shared\bulwark.hpp"

_lootRoomPos = call loot_fnc_getRandomLootRoom;
if(!isNil "_lootRoomPos") then {
    _lootHolder = createVehicle ["WeaponHolderSimulated_Scripted", [_lootRoomPos select 0, _lootRoomPos select 1]];
	hideObjectGlobal _lootHolder;
	_lootHolder enableSimulationGlobal false;
	_randItemType = randItemTypes selectRandomWeighted randItemChances;
	switch (_randItemType) do {
		case "UNIFORMS": {
			private _clothes = selectRandom LOOT_POOL_UNIFORMS;
			_lootHolder addItemCargoGlobal [_clothes, 1];
		};
		case "VESTS": {
			private _clothes = selectRandom LOOT_POOL_VESTS;
			_lootHolder addItemCargoGlobal [_clothes, 1];
		};
		case "HEADGEAR": {
			private _clothes = selectRandom LOOT_POOL_UNIFORMS;
			_lootHolder addItemCargoGlobal [_clothes, 1];
		};
		case "ITEMS": {
			private _items = selectRandom LOOT_POOL_ITEMS;
			_lootHolder addItemCargoGlobal [_items, 1];
		};
		case "GLASSES": {
			private _items = selectRandom LOOT_POOL_GLASSES;
			_lootHolder addItemCargoGlobal [_items, 1];
		};
		case "ATTACHMENT": {
			private _items = selectRandom LOOT_POOL_ATTACHMENT;
			_lootHolder addItemCargoGlobal [_items, 1];
		};
		case "BACKPACKS": {
			private _backpack = selectRandom LOOT_POOL_BACKPACKS;
			_lootHolder addBackpackCargoGlobal [_backpack, 1];
		};
		case "STATICGUNS": {
			private _backpack = selectRandom LOOT_POOL_STATICGUNS;
			_lootHolder addBackpackCargoGlobal [_backpack, 1];
		};
		case "AUTOSTATICGUNS": {
			private _backpack = selectRandom LOOT_POOL_AUTOSTATICGUNS;
			_lootHolder addBackpackCargoGlobal [_backpack, 1];
		};
		case "DRONES": {
			private _backpack = selectRandom LOOT_POOL_DRONES;
			_lootHolder addBackpackCargoGlobal [_backpack, 1];
		};
		case "STATICSUPPORTS": {
			private _backpack = selectRandom LOOT_POOL_STATICSUPPORTS;
			_lootHolder addBackpackCargoGlobal [_backpack, 1];
		};
		case "EXPLOSIVES": {
			private _explosive = selectRandom LOOT_POOL_EXPLOSIVES;
			_lootHolder addMagazineCargoGlobal [_explosive, 1 + (floor random 3)];
		};
		case "GREANDES": {
			private _explosive = selectRandom LOOT_POOL_GRENADES;
			_lootHolder addMagazineCargoGlobal [_explosive, 1 + (floor random 3)];
		};
		case "MG": {
			private _weapon = selectRandom LOOT_POOL_MG;
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
			private _ammoArray = [configFile >> "CfgWeapons" >> _weapon,"magazines",[]] call BIS_fnc_returnConfigEntry;
			if (count _ammoArray > 0) then {
				private _ammo = selectRandom _ammoArray;
				private _minMag = BULWARK_PARAM_AMMO_MGMIN call shared_fnc_getCurrentParamValue;
				private _maxMag = BULWARK_PARAM_AMMO_MGMAX call shared_fnc_getCurrentParamValue;
				_lootHolder addMagazineCargoGlobal [_ammo, (floor random (_maxMag - _minMag)) + _minMag];
			};
		};
		case "SMG": {
			private _weapon = selectRandom LOOT_POOL_SMG;
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
			private _ammoArray = [configFile >> "CfgWeapons" >> _weapon,"magazines",[]] call BIS_fnc_returnConfigEntry;
			if (count _ammoArray > 0) then {
			private _ammo = selectRandom _ammoArray;
				private _minMag = BULWARK_PARAM_AMMO_SMGMIN call shared_fnc_getCurrentParamValue;
				private _maxMag = BULWARK_PARAM_AMMO_SMGMAX call shared_fnc_getCurrentParamValue;
				_lootHolder addMagazineCargoGlobal [_ammo, (floor random (_maxMag - _minMag)) + _minMag];
			};
		};
		case "SNIPER": {
			private _weapon = selectRandom LOOT_POOL_SNIPER;
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
			private _ammoArray = [configFile >> "CfgWeapons" >> _weapon,"magazines",[]] call BIS_fnc_returnConfigEntry;
			if (count _ammoArray > 0) then {
				private _ammo = selectRandom _ammoArray;
				private _minMag = BULWARK_PARAM_AMMO_SNIPERMIN call shared_fnc_getCurrentParamValue;
				private _maxMag = BULWARK_PARAM_AMMO_SNIPERMAX call shared_fnc_getCurrentParamValue;
				_lootHolder addMagazineCargoGlobal [_ammo, (floor random (_maxMag - _minMag)) + _minMag];
			};
		};
		case "SHOTGUN": {
			private _weapon = selectRandom LOOT_POOL_SHOTGUN;
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
			private _ammoArray = [configFile >> "CfgWeapons" >> _weapon,"magazines",[]] call BIS_fnc_returnConfigEntry;
			if (count _ammoArray > 0) then {
				private _ammo = selectRandom _ammoArray;
				private _minMag = BULWARK_PARAM_AMMO_SHOTGUNMIN call shared_fnc_getCurrentParamValue;
				private _maxMag = BULWARK_PARAM_AMMO_SHOTGUNMAX call shared_fnc_getCurrentParamValue;
				_lootHolder addMagazineCargoGlobal [_ammo, (floor random (_maxMag - _minMag)) + _minMag];
			};
		};
		case "HANDGUN": {
			private _weapon = selectRandom LOOT_POOL_HANDGUN;
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
			private _ammoArray = [configFile >> "CfgWeapons" >> _weapon,"magazines",[]] call BIS_fnc_returnConfigEntry;
			if (count _ammoArray > 0) then {
				private _ammo = selectRandom _ammoArray;
				private _minMag = BULWARK_PARAM_AMMO_HANDGUNMIN call shared_fnc_getCurrentParamValue;
				private _maxMag = BULWARK_PARAM_AMMO_HANDGUNMAX call shared_fnc_getCurrentParamValue;
				_lootHolder addMagazineCargoGlobal [_ammo, (floor random (_maxMag - _minMag)) + _minMag];
			};
		};
		case "LAUCNHER": {
			private _weapon = selectRandom LOOT_POOL_LAUNCHER;
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
			private _ammoArray = [configFile >> "CfgWeapons" >> _weapon,"magazines",[]] call BIS_fnc_returnConfigEntry;
			if (count _ammoArray > 0) then {
				private _ammo = selectRandom _ammoArray;
				private _minMag = BULWARK_PARAM_AMMO_LAUNCHERMIN call shared_fnc_getCurrentParamValue;
				private _maxMag = BULWARK_PARAM_AMMO_LAUNCHERMAX call shared_fnc_getCurrentParamValue;
				_lootHolder addMagazineCargoGlobal [_ammo, (floor random (_maxMag - _minMag)) + _minMag];
			};
		};
		case "ASSAULT": {
			private _weapon = selectRandom LOOT_POOL_ASSAULT;
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
			private _ammoArray = [configFile >> "CfgWeapons" >> _weapon,"magazines",[]] call BIS_fnc_returnConfigEntry;
			if (count _ammoArray > 0) then {
				private _ammo = selectRandom _ammoArray;
				private _minMag = BULWARK_PARAM_AMMO_ASSAULTMIN call shared_fnc_getCurrentParamValue;
				private _maxMag = BULWARK_PARAM_AMMO_ASSAULTMAX call shared_fnc_getCurrentParamValue;
				_lootHolder addMagazineCargoGlobal [_ammo, (floor random (_maxMag - _minMag)) + _minMag];
			};
		};
	};

	// This lets the items re-orient themselves by "falling and landing" wherever they spawned.
	// Otherwise they get some goofy orientation
	_lootHolder setPos [_lootRoomPos select 0, _lootRoomPos select 1, (_lootRoomPos select 2) + 0.1];

	//activeLoot pushback _lootHolder; // Add object to array for later cleanup

	preInitLoot pushBack _lootHolder;
	[_lootHolder, ['ContainerClosed', { // Add event to delete container if empty
			params ['_container','_player'];
			[_container] call loot_fnc_deleteIfEmpty;
	}]] remoteExec ['addEventHandler', 0];

    _lootHolder;
} else {
    nil;
};