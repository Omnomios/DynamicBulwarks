_locations = (nearestLocations [[0,0,0], ["NameCity", "NameCityCapital", "Airport"], 40000]); //"NameLocal",
BulwarkRoomPos = nil;

while {isNil "BulwarkRoomPos"} do {
	bulwarkCity = locationPosition (selectRandom _locations);
	while {true} do {
		_randCityLocation = [(bulwarkCity select 0) + (random [-100, 0, 100]),(bulwarkCity select 1) + (random [-100, 0, 100]), 0];
		bulwarkBulding = nearestBuilding _randCityLocation;
		bulwarkRooms = bulwarkBulding buildingPos -1;
		if ((count bulwarkRooms) > 5) exitWith {
			BulwarkRoomPos = selectRandom bulwarkRooms;
		};
	}
};

// Lootbox
lootBoxRoom = selectRandom bulwarkRooms; publicVariable "lootBoxRoom";

lootBox = createVehicle ["Land_WoodenBox_F", lootBoxRoom, [], 0, "CAN_COLLIDE"];
lootBox enableSimulationGlobal false;
publicVariable "lootBox";

lootBoxPos    = getPos lootBox; publicVariable "lootBoxPos";
lootBoxPosATL = getPosATL lootBox; publicVariable "lootBoxPosATL";


//lootBox addAction [
//    "<t color='#FF0000'>Spin the box!</t>", {
//		//TODO: should use the return from spend call
//		if(player getVariable "killPoints" >= 20) then {
//			[player, 20] call killPoints_fnc_spend;
//			// Call lootspin script on ALL clients
//			[[lootBoxPos, lootBoxPosATL], "loot\spin\main.sqf"] remoteExec ["BIS_fnc_execVM", 0];
//		};
//    }
//];

[lootBox, [
	    "<t color='#FF0000'>Spin the box!</t>", {
		//TODO: should use the return from spend call
		if(player getVariable "killPoints" >= 20) then {
			[player, 20] call killPoints_fnc_spend;
			// Call lootspin script on ALL clients
			[[lootBoxPos, lootBoxPosATL], "loot\spin\main.sqf"] remoteExec ["BIS_fnc_execVM", 0];
		};
    }
]] remoteExec ["addAction", 0];

wabbit = createVehicle ["Rabbit_F", lootBoxRoom, [], 0 , "CAN_COLLIDE"];
wabbit attachTo [lootBox,[0,-.2,0.6]];
publicVariable "wabbit";

_crateRoom = selectRandom bulwarkRooms;
_emptyCrate = createVehicle ["B_supplyCrate_F", _crateRoom, [], 0, "CAN_COLLIDE"];
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
