_locations = (nearestLocations [[0,0,0], ["NameCity", "NameCityCapital", "Airport"], 40000]); //"NameLocal",
BulwarkRoomPos = nil;

while {isNil "BulwarkRoomPos"} do {
	bulwarkCity = locationPosition (selectRandom _locations);
	_randCityLocation = [(bulwarkCity select 0) + (random [-100, 0, 100]),(bulwarkCity select 1) + (random [-100, 0, 100]), 0];
	bulwarkBulding = nearestBuilding _randCityLocation;
	bulwarkRooms = bulwarkBulding buildingPos -1;
	BulwarkRoomPos = selectRandom bulwarkRooms;
};

_crateRoom = selectRandom bulwarkRooms;
_ammoBox = createVehicle ["Land_Ammobox_rounds_F", _crateRoom, [], 0, "CAN_COLLIDE"];
_ammoBox addAction ["FILL AMMO", "supports\ammoDrop.sqf"];

_crateRoom = selectRandom bulwarkRooms;
_emptyCrate = createVehicle ["B_supplyCrate_F", _crateRoom, [], 0, "CAN_COLLIDE"];

// Lootbox
_lootBoxRoom = selectRandom bulwarkRooms;
_lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 0, "CAN_COLLIDE"];
_lootBox enableSimulationGlobal false;
_lootBox addAction [
"<t color='#FF0000'>Spin the box!</t>", {
	systemChat format ["%1, %2", _lootBox, this];
	_handle = [_lootBox] execVM "loot\lootspin.sqf";
}
];
_wabbit = createVehicle ["Rabbit_F", _lootBoxRoom, [], 0 , "CAN_COLLIDE"];
_wabbit attachTo [_lootBox,[0,-.2,0.6]];


_emptyCrate allowDamage false;
clearItemCargoGlobal _emptyCrate;
clearWeaponCargoGlobal _emptyCrate;
clearMagazineCargoGlobal _emptyCrate;
clearBackpackCargoGlobal _emptyCrate;
_emptyCrate addWeaponCargoGlobal["hgun_P07_F",10];
_emptyCrate addMagazineCargoGlobal ["16Rnd_9x21_Mag",20];


_marker1 = createMarker ["Mission Area", bulwarkCity];
"Mission Area" setMarkerShape "ELLIPSE";
"Mission Area" setMarkerSize [150, 150];
"Mission Area" setMarkerColor "ColorWhite";
