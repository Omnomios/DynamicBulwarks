BulwarkRoomPos = nil;

_TWOTHIRDS = 0.6666;

while {isNil "BulwarkRoomPos"} do {
	bulwarkCity = selectRandom BULWARK_LOCATIONS;
	while {true} do {
		_randCityLocation = [(bulwarkCity select 0) + (random [-BULWARK_RADIUS*_TWOTHIRDS, 0, BULWARK_RADIUS*_TWOTHIRDS]),(bulwarkCity select 1) + (random [-BULWARK_RADIUS*_TWOTHIRDS, 0, BULWARK_RADIUS*_TWOTHIRDS]), 0];
		bulwarkBulding = nearestBuilding _randCityLocation;
		bulwarkRooms = bulwarkBulding buildingPos -1;
		if ((count bulwarkRooms) > 5) exitWith {
			BulwarkRoomPos = selectRandom bulwarkRooms;
		};
	}
};

/*
wabbit = createVehicle ["Rabbit_F", lootBoxRoom, [], 0 , "CAN_COLLIDE"];
wabbit attachTo [lootBox,[0,-.2,0.6]];
publicVariable "wabbit";
*/

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
"Mission Area" setMarkerSize [BULWARK_RADIUS, BULWARK_RADIUS];
"Mission Area" setMarkerColor "ColorWhite";

lootHouses = bulwarkCity nearObjects ["House", BULWARK_RADIUS];

/* Spinner Box */
_lootBulding = selectRandom lootHouses;
_lootRooms = _lootBulding buildingPos -1;
_lootBoxRoom = selectRandom _lootRooms;

lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 0, "CAN_COLLIDE"];
lootBox enableSimulationGlobal false;
publicVariable "lootBox";
lootBoxPos    = getPos lootBox; publicVariable "lootBoxPos";
lootBoxPosATL = getPosATL lootBox; publicVariable "lootBoxPosATL";
[lootBox, [
	    "<t color='#FF0000'>Spin the box!</t>", {
		//TODO: should use the return from spend call
		if(player getVariable "killPoints" >= SCORE_RANDOMBOX) then {
			[player, SCORE_RANDOMBOX] call killPoints_fnc_spend;
			// Call lootspin script on ALL clients
			[[lootBoxPos, lootBoxPosATL], "loot\spin\main.sqf"] remoteExec ["BIS_fnc_execVM", player];
		};
    }
]] remoteExec ["addAction", 0, true];
/*
_boxMkr = createMarker [netId lootBox, getPos lootBox];
_boxMkr setMarkerShape "ICON";
_boxMkr setMarkerType "hd_dot";
_boxMkr setMarkerColor "ColorGreen";
*/
