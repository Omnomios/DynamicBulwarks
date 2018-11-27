/**
*  createBase
*
*  Selects a base location and spawns required mission items
*
*  Domain: Server
**/

PLAYER_OBJECT_LIST =[]; //create empty variable for player placed objects

bulwarkBox = createVehicle ["B_supplyCrate_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_bulMon = createVehicle ["Land_Laptop_device_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_bulMon allowDamage false;
bulwarkBox allowDamage false;
[_bulMon,[0,"preview.paa"]] remoteExec ["setObjectTexture",0,true];
_bulMon enableSimulation false;
_bulMon attachTo [bulwarkBox, [0,0.1,0.6]];
_bulMon setDir 180;

_isWater = true;
while {_isWater} do {
	_bulwarkLocation = [BULWARK_LOCATIONS, BULWARK_RADIUS] call bulwark_fnc_bulwarkLocation;
	bulwarkRoomPos = _bulwarkLocation select 0;
	bulwarkCity = _bulwarkLocation select 1;
	bulwarkBox setPosASL bulwarkRoomPos;
	_isWater = surfaceIsWater (getPos bulwarkBox);
};

publicVariable "bulwarkCity";

clearItemCargoGlobal bulwarkBox;
clearWeaponCargoGlobal bulwarkBox;
clearMagazineCargoGlobal bulwarkBox;
clearBackpackCargoGlobal bulwarkBox;
//bulwarkBox addWeaponCargoGlobal["hgun_P07_F",10];
//bulwarkBox addMagazineCargoGlobal ["16Rnd_9x21_Mag",20];
if(BULWARK_MEDIKITS > 0) then {
	bulwarkBox addItemCargoGlobal ["Medikit", BULWARK_MEDIKITS];
};

//Add actions to Bulwark Box
[bulwarkBox, ["<t color='#00ffff'>" + "Pickup", "bulwark\moveBox.sqf","",1,false,false,"true","true",2.5]] remoteExec ["addAction", 0, true];
[bulwarkBox, ["<t color='#00ff00'>" + "Shop", "[] spawn bulwark_fnc_purchaseGui; ShopCaller = _this select 1","",1.5,false,false,"true","true",2.5]] remoteExec ["addAction", 0, true];
[bulwarkBox, ["<t color='#ff0000'>" + "Heal Yourself: 500p", "
	_player = _this select 1;
	_points = _player getVariable 'killPoints';
	if (_points >= 500) then {
		[_player, 0] remoteExec ['setDamage', 0, true];
		[_player, 500] remoteExec ['killPoints_fnc_spend', 2];
		[true] remoteExec ['disableUserInput', _player];
		[_player, 'AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon'] remoteExec ['switchMove', 0];
		sleep 1;
		[false] remoteExec ['disableUserInput', _player];
	};
","",1,false,false,"true","true",2.5]] remoteExec ["addAction", 0, true];

//Add Bulwark Box to Zeus
mainZeus addCuratorEditableObjects [[bulwarkBox], true];

//Add EH for text to explain the FAK to Medkit feature
[bulwarkBox, ["ContainerOpened", {
	_playerId = _this select 1;
	["<t size = '.5'>Place 15 FAKs into the Bulwark to convert them into a Medikit</t>", 0, 1, 60, 0] remoteExec ["BIS_fnc_dynamicText", _playerId];
}]] remoteExec ["addEventHandler", 0, true];
[bulwarkBox, ["ContainerClosed", {
	_playerId = _this select 1;
	["", 0, 1, 0.05, 0] remoteExec ["BIS_fnc_dynamicText", _playerId];
}]] remoteExec ["addEventHandler", 0, true];

/* Place a table in the room for the lulz */
_relPos = [bulwarkRoomPos, 10, 0] call BIS_fnc_relPos;
_hits = lineIntersectsSurfaces [bulwarkRoomPos vectorAdd [0,0,0.2], _relPos, bulwarkBox, objNull, true, 1, "GEOM", "NONE"];
_boxPos = getPos bulwarkBox;

if(count _hits > 0) then {
	_hit = _hits select 0;
	_obj = _hit select 2;
	_objDir = getDir _obj;

	_furthestDist = 0;
	_furthestAngle = 0;
	_furthestPos = [0,0,0];
	_furthestDir = 0;
	for ("_i") from 0 to 360 step 22.5 do {
		_checkAngle = _objDir + _i;
		_relPos = [bulwarkRoomPos, 10, _checkAngle] call BIS_fnc_relPos;
		_hits = lineIntersectsSurfaces [bulwarkRoomPos vectorAdd [0,0,0.2], _relPos, bulwarkBox, objNull, true, 1, "GEOM", "NONE"];
		if(count _hits > 0) then {
			_hit = _hits select 0;
			_hitPos = _hit select 0;
			_distance = _boxPos distance _hitPos;
			_normalDir = [[0,0,0],(_hit select 1)] call BIS_fnc_dirTo;

			if(_distance > _furthestDist) then {
				_furthestDist = _distance;
				_furthestAngle = _checkAngle;
				_furthestPos = _hitPos;
				_furthestDir = _normalDir;
			};
		};
	};

	_tablePos = [_furthestPos, -0.5, _furthestAngle] call BIS_fnc_relPos;
	table = createVehicle ["Land_TableSmall_01_f", [0,0,0], [], 0, "CAN_COLLIDE"];
	table setPos [_tablePos select 0, _tablePos select 1, _boxPos select 2];
	table setDir _furthestDir-90;
	bulwarkBox setDir _objDir;
};

_marker1 = createMarker ["Mission Area", bulwarkCity];
"Mission Area" setMarkerShape "ELLIPSE";
"Mission Area" setMarkerSize [BULWARK_RADIUS, BULWARK_RADIUS];
"Mission Area" setMarkerColor "ColorWhite";

lootHouses = bulwarkCity nearObjects ["House", BULWARK_RADIUS];

[] execVM "bulwark\fakToMedkit.sqf";

/* Spinner Box */

_lootBoxRoom = while {true} do {
	_lootBulding = selectRandom lootHouses;
	_lootRooms = _lootBulding buildingPos -1;
	_lootRoom = selectRandom _lootRooms;
	if(!isNil "_lootRoom") exitWith {_lootRoom};
};
lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 4];
publicVariable "lootBox";
[lootBox, ["<t color='#00ffff'>" + "Pickup", "bulwark\moveSpinBox.sqf"]] remoteExec ["addAction", 0, true];
[lootBox, [
	format ["<t color='#FF0000'>Spin the box! %1p</t>", SCORE_RANDOMBOX], "
		lootBoxPos    = getPos lootBox;
		lootBoxPosATL = getPosATL lootBox;
		lootBoxDir    = getDir lootBox;
		_player = _this select 1;
		_points = _player getVariable 'killPoints';
		if(_points >= SCORE_RANDOMBOX) then {
			[_player, SCORE_RANDOMBOX] remoteExec ['killPoints_fnc_spend', 2];
			[[lootBoxPos, lootBoxPosATL, lootBoxDir], 'loot\spin\main.sqf'] remoteExec ['execVM', 2];
		};
	"
]] remoteExec ["addAction", 0, true];
