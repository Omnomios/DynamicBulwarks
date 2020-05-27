_lootRoomPos = call loot_fnc_getRandomLootRoom;
if(!isNil "_lootRoomPos") then {
    _lootHolder = createVehicle ["WeaponHolderSimulated_Scripted", [_lootRoomPos select 0, _lootRoomPos select 1]];
	hideObjectGlobal _lootHolder;
	_lootHolder enableSimulationGlobal false;
	_randItemTypes = [];
	_randItemChances = [];
	if (count LOOT_APPAREL_POOL > 0) then {
		_randItemTypes pushBack "clothes";
		_randItemChances pushBack clothesTypeChance;
	};
	if (count LOOT_ITEM_POOL > 0) then {
		_randItemTypes pushBack "items";
		_randItemChances pushBack itemsTypeChance;
	};
	if (count LOOT_STORAGE_POOL > 0) then {
		_randItemTypes pushBack "backpacks";
		_randItemChances pushBack backpacksTypeChance;
	};
	if (count LOOT_EXPLOSIVE_POOL > 0) then {
		_randItemTypes pushBack "explosives";
		_randItemChances pushBack explosivesTypeChance;
	};
	if (count LOOT_WEAPON_POOL > 0) then {
		_randItemTypes pushBack "weapons";
		_randItemChances pushBack weaponsTypeChance;
	};

	_randItemType = _randItemTypes selectRandomWeighted _randItemChances;
	switch (_randItemType) do {
		case "clothes": {
			_clothes = selectRandom LOOT_APPAREL_POOL;
			_lootHolder addItemCargoGlobal [_clothes, 1];
		};
		case "items": {
			_items = selectRandom LOOT_ITEM_POOL;
			_lootHolder addItemCargoGlobal [_items, 1];
		};
		case "backpacks": {
			_backpack = selectRandom LOOT_STORAGE_POOL;
			_lootHolder addBackpackCargoGlobal [_backpack, 1];
		};
		case "explosives": {
			_explosive = selectRandom LOOT_EXPLOSIVE_POOL;
			_lootHolder addMagazineCargoGlobal [_explosive, 1 + (floor random 3)];
		};
		case "weapons": {
			_randWeaponTypes = [];
			_randWeaponChances = [];
			if (count LOOT_WEAPON_SNIPER_POOL > 0) then {
				_randWeaponTypes pushBack "sniper";
				_randWeaponChances pushBack sniperWeapTypeChance;
			};
			if (count LOOT_WEAPON_ASSAULT_POOL > 0) then {
				_randWeaponTypes pushBack "assault";
				_randWeaponChances pushBack assaultWeapTypeChance;
			};
			if (count LOOT_WEAPON_SMG_POOL > 0) then {
				_randWeaponTypes pushBack "smg";
				_randWeaponChances pushBack smgWeapTypeChance;
			};
			if (count LOOT_WEAPON_MG_POOL > 0) then {
				_randWeaponTypes pushBack "mg";
				_randWeaponChances pushBack mgWeapTypeChance;
			};
			if (count LOOT_WEAPON_LAUNCHER_POOL > 0) then {
				_randWeaponTypes pushBack "launcher";
				_randWeaponChances pushBack launcherWeapTypeChance;
			};
			if (count LOOT_WEAPON_HANDGUN_POOL > 0) then {
				_randWeaponTypes pushBack "handgun";
				_randWeaponChances pushBack handgunWeapTypeChance;
			};

			_type = _randWeaponTypes selectRandomWeighted _randWeaponChances;
			_weapon = [_type] call DBW_selectWeapon;
			_lootHolder addWeaponCargoGlobal [_weapon, 1];
			_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			_ammo = selectRandom _ammoArray;
			_lootHolder addMagazineCargoGlobal [_ammo, 1];
			_magString = format ["mag%1",_type];
			_getMag = call compile _magString;
			_getMag params ["_minMag","_maxMag"];
			_lootHolder addMagazineCargoGlobal [_ammo, (floor random (_maxMag - _minMag)) + _minMag];
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