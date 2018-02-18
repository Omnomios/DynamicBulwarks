_targetPos = _this select 0;
_angle = round random 180;
_height = 100;
_offsX = 0;
_offsY = 1000;
_pointX = _offsX*(cos _angle) - _offsY*(sin _angle);
_pointY = _offsX*(sin _angle) + _offsY*(cos _angle);

_dropStart = [(_targetPos select 0)+_pointX, (_targetPos select 1)+_pointY, _height];
_dropEnd   = [(_targetPos select 0)-_pointX*2, (_targetPos select 1)-_pointY*2, _height];

// Spawn aircraft
[_dropStart, _dropEnd, _height, "NORMAL", _this select 2, WEST] call BIS_fnc_ambientFlyby;
_dropVehc = (nearestObjects [_dropStart, [_this select 2], 40]) select 0;

sleep 5;
// Open cargo door
_dropVehc animateDoor ['Door_1_source', 1];
sleep 5;

// Drop cargo
_playerCount = count playableUnits;
_parachute = "B_Parachute_02_F" CreateVehicle [0,0,0];
_parachute setPos [getPos _dropVehc select 0, getPos _dropVehc select 1, (getPos _dropVehc select 2)-5];
_supplyBox = createVehicle ["Cargonet_01_box_F", [0,0,0], [], 0, "CAN_COLLIDE"];
[_supplyBox, _this select 1] remoteExec ["addAction", 0];
_supplyBox attachTo [_parachute, [0,0,0]];
_supplyBox allowDamage false;

// Open cargo door
_dropVehc animateDoor ['Door_1_source', 0];

waitUntil {getpos _supplyBox select 2<4};
detach _supplyBox;
