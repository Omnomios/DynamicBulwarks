BulwarkRoomPos = nil;

_TWOTHIRDS = 0.6666;

while {isNil "BulwarkRoomPos"} do {
	bulwarkCity = selectRandom BULWARK_LOCATIONS;
	while {true} do {
		_randCityLocation = [(bulwarkCity select 0) + (random [-BULWARK_RADIUS*_TWOTHIRDS, 0, BULWARK_RADIUS*_TWOTHIRDS]),(bulwarkCity select 1) + (random [-BULWARK_RADIUS*_TWOTHIRDS, 0, BULWARK_RADIUS*_TWOTHIRDS]), 0];
		bulwarkBulding = nearestBuilding _randCityLocation;
		bulwarkRooms = bulwarkBulding buildingPos -1;
		if ((count bulwarkRooms) >= BULWARK_MINROOMS) exitWith {
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
[_emptyCrate, ["Pickup", "loot\moveBox.sqf"]] remoteExec ["addAction", 0];
[_emptyCrate, ["Shop", "[] spawn guis_fnc_startBoxGui; ShopCaller = _this select 1"]] remoteExec ["addAction", 0];


_marker1 = createMarker ["Mission Area", bulwarkCity];
"Mission Area" setMarkerShape "ELLIPSE";
"Mission Area" setMarkerSize [BULWARK_RADIUS, BULWARK_RADIUS];
"Mission Area" setMarkerColor "ColorWhite";

lootHouses = bulwarkCity nearObjects ["House", BULWARK_RADIUS];

/* Spinner Box */
_lootBoxRoom = while {true} do {
	_lootBulding = selectRandom lootHouses;
	_lootRooms = _lootBulding buildingPos -1;
	_lootRoom = selectRandom _lootRooms;
	if(!isNil "_lootRoom") exitWith {_lootRoom};
};
lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 0, "CAN_COLLIDE"];
publicVariable "lootBox";
sleep 2;
lootBoxPos    = getPos lootBox; publicVariable "lootBoxPos";
lootBoxPosATL = getPosATL lootBox; publicVariable "lootBoxPosATL";
[lootBox, [
	    "<t color='#FF0000'>Spin the box!</t>", {
		//TODO: should use the return from spend call
		if(player getVariable "killPoints" >= SCORE_RANDOMBOX) then {
			[player, SCORE_RANDOMBOX] call killPoints_fnc_spend;
			// Call lootspin script on ALL clients
			[[lootBoxPos, lootBoxPosATL], "loot\spin\main.sqf"] remoteExec ["BIS_fnc_execVM", player];
		} else {
			[format ["<t size='0.6' color='#ff3300'>%1 points required to spin the box</t>", SCORE_RANDOMBOX], -0.6, -0.35] call BIS_fnc_dynamicText;
		};
    }
]] remoteExec ["addAction", 0, true];
lootBox enableSimulationGlobal false;
/*
_boxMkr = createMarker [netId lootBox, getPos lootBox];
_boxMkr setMarkerShape "ICON";
_boxMkr setMarkerType "hd_dot";
_boxMkr setMarkerColor "ColorGreen";
*/

_lootRoom = selectRandom bulwarkRooms;
_artRadio = createVehicle ["Land_PortableLongRangeRadio_F", _lootRoom, [], 0, "CAN_COLLIDE"];
[_artRadio, ["Artilery", "supports\artillery.sqf"]] remoteExec ["addAction", 0];
