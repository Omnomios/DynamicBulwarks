/**
*  spawnLoot
*
*  Spawns loot randomly around the play area
*
*  Domain: Server
**/

activeLoot = [];
lootDebugMarkers = [];


/* Item to reveal all loot on the Map (1 spawns every wave) */
_droneRoom = while {true} do {
	_lootBulding = selectRandom lootHouses;
	_lootRooms = _lootBulding buildingPos -1;
	_lootRoom = selectRandom _lootRooms;
	if(!isNil "_lootRoom") exitWith {_lootRoom};
};
_droneSupport = createVehicle ["Box_C_UAV_06_Swifd_F", _droneRoom, [], 0, "CAN_COLLIDE"];
[_droneSupport, ["<t color='#ff00ff'>" + "Reveal loot", "[ [],'supports\lootDrone.sqf'] remoteExec ['execVM',0];","",1,true,false,"true","true",2.5]] remoteExec ["addAction", 0, true];

activeLoot pushback _droneSupport;

// Item to give KillPoints (1 spawns every wave)
_pointsLootRoom = while {true} do {
	_lootBulding = selectRandom lootHouses;
	_lootRooms = _lootBulding buildingPos -1;
	_lootRoom = selectRandom _lootRooms;
	if(!isNil "_lootRoom") exitWith {_lootRoom};
};
pointsLoot = createVehicle ["Land_Money_F", _pointsLootRoom, [], 0, "CAN_COLLIDE"];
[pointsLoot, ["<t color='#00ff00'>" + "Collect Points", "loot\lootPoints.sqf","",1,true,false,"true","true",2.5]] remoteExec ["addAction", 0, true];

activeLoot pushback pointsLoot;

/* Master loot spawner */
_houseCount = floor random 3; // Mix up the loot houses a bit
_houseLoot = 0;
_roomCount = 0;
{
	_houseCount = _houseCount + 1;
	if (_houseCount mod LOOT_HOUSE_DISTRIBUTION == 0) then {
		_houseLoot = _houseLoot + 1;

		_lootBulding = _x;
		_lootRooms = _lootBulding buildingPos -1;

		_roomCount = -1;
		{
			_roomCount = _roomCount + 1;
			if (_roomCount mod LOOT_ROOM_DISTRIBUTION == 0) then {

				_lootRoomPos = _x;
				_lootHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;

				switch (floor random 6) do {
					case 0: {
						_weapon = selectRandom LOOT_WEAPON_POOL;
						_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
						_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1];
						_lootHolder addWeaponCargoGlobal [_weapon, 1];
					};
					case 1: {
						_weapon = selectRandom LOOT_WEAPON_POOL;
						_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
						_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1 + (floor random 3)];
					};
					case 2: {
						_clothes = selectRandom LOOT_APPAREL_POOL;
						_lootHolder addItemCargoGlobal [_clothes, 1];
					};
					case 3: {
						_items = selectRandom LOOT_ITEM_POOL;
						_lootHolder addItemCargoGlobal [_items, 1];
					};
					case 4: {
						_backpack = selectRandom LOOT_STORAGE_POOL;
						_lootHolder addBackpackCargoGlobal [_backpack, 1];
					};
					case 5: {
						_explosive = selectRandom LOOT_EXPLOSIVE_POOL;
						_lootHolder addMagazineCargoGlobal [_explosive, 1 + (floor random 3)];
					};
				};
				_lootHolder setPos [_lootRoomPos select 0, _lootRoomPos select 1, (_lootRoomPos select 2) + 0.1];

				activeLoot pushback _lootHolder; // Add object to array for later cleanup

				[_lootHolder, ["ContainerClosed", { // Add event to delete container if empty
						params ["_container"];
						if ((magazineCargo _container isEqualTo []) && (weaponCargo _container isEqualTo []) && (backpackCargo _container isEqualTo [])) exitWith {
							[_container] remoteExec ["deleteVehicle", 2];
						};
				}]] remoteExec ['addEventHandler', 0];
			};
		} forEach _lootRooms;
	};

} forEach lootHouses;

/* Supply Drop */
[bulwarkCity, ["<t color='#00ff00'>" + "FILL AMMO", "supports\ammoDrop.sqf","",2,true,false,"true","true",4], "B_T_VTOL_01_vehicle_F"] remoteExec ["supports_fnc_supplyDrop", 2];
