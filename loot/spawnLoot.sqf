/** Config **/
lootHouseProb = 2;  // Every nth house
lootRoomProb = 3;   // Every nth position
lootDebug = false;   // Loot spawning visibility

/* Start Script */
activeLoot = [];
lootDebugMarkers = [];

/* Item to reveal hostiles on Map (1 spawns every wave) */
_randCityLocation = [(bulwarkCity select 0) + (random [-125, 0, 125]),(bulwarkCity select 1) + (random [-125, 0, 125]), 0];
_lootBulding = nearestBuilding _randCityLocation;
_lootRooms = _lootBulding buildingPos -1;
_droneRoom = selectRandom _lootRooms;
_droneSupport = createVehicle ["Box_C_UAV_06_Swifd_F", _droneRoom, [], 0, "CAN_COLLIDE"];
_droneSupport addAction ["Reveal enemies", "supports\reconDrone.sqf"];

if(lootDebug) then {
	_houseMkr = createMarker [netId _droneSupport, _droneRoom];
	_houseMkr setMarkerShape "ICON";
	_houseMkr setMarkerType "hd_dot";
	_houseMkr setMarkerColor "ColorPink";
	lootDebugMarkers pushback _houseMkr;
};

activeLoot pushback _droneSupport;


/* Master loot spawner */
if(lootDebug) then { systemChat "Started loot spawn"; };
_houseCount = 0;
_houseLoot = 0;
_roomCount = 0;
{
	_houseCount = _houseCount + 1;
	if (_houseCount mod lootHouseProb == 0) then {
		_houseLoot = _houseLoot + 1;

		_lootBulding = _x;
		_lootRooms = _lootBulding buildingPos -1;

		if(lootDebug) then {
			_houseMkr = createMarker [netId _lootBulding, getPos _lootBulding];
			_houseMkr setMarkerShape "ICON";
			_houseMkr setMarkerType "hd_dot";
			_houseMkr setMarkerColor "ColorBlue";
			lootDebugMarkers pushback _houseMkr;
		};

		_roomCount = -1;
		{
			_roomCount = _roomCount + 1;
			if (_roomCount mod lootRoomProb == 0) then {

				_lootRoomPos = _x;
				_lootHolder = "WeaponHolderSimulated_Scripted" createVehicle _lootRoomPos;

				switch (floor random 5) do {
					case 0: {
						_weapon = selectRandom List_AllWeapons;
						_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
						_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1];
						_lootHolder addWeaponCargoGlobal [_weapon, 1];
					};
					case 1: {
						_weapon = selectRandom List_AllWeapons;
						_ammoArray = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
						_lootHolder addMagazineCargoGlobal [selectRandom _ammoArray, 1 + (floor random 3)];
					};
					case 2: {
						_clothes = selectRandom List_AllClothes;
						_lootHolder addItemCargoGlobal [_clothes, 1];
					};
					case 3: {
						_optics = selectRandom List_Optics;
						_lootHolder addItemCargoGlobal [_optics, 1];
					};
					case 4: {
						_backpack = selectRandom List_AllStorage;
						_lootHolder addBackpackCargoGlobal  [_backpack, 1];
					};
				};
				_lootHolder setPos [_lootRoomPos select 0, _lootRoomPos select 1, (_lootRoomPos select 2) + 0.1];

				if(lootDebug) then {
					_houseMkr = createMarker [netId _lootHolder, getPos _lootHolder];
					_houseMkr setMarkerShape "ICON";
					_houseMkr setMarkerType "hd_dot";
					_houseMkr setMarkerColor "ColorRed";
					lootDebugMarkers pushback _houseMkr;
				};

				activeLoot pushback _lootHolder; // Add object to array for later cleanup
			};
		} forEach _lootRooms;
	};

} forEach lootHouses;

if(lootDebug) then { systemChat format ["Loot spawn complete (%1/%2)", _houseCount, _houseLoot]; };

/* Supply Drop */
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
