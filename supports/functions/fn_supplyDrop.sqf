_targetPos = _this select 0;
_cargo     = _this select 1;
_aircraft  = _this select 2;

_angle = round random 180;
_height = 300;
_offsX = 0;
_offsY = 1000;
_pointX = _offsX*(cos _angle) - _offsY*(sin _angle);
_pointY = _offsX*(sin _angle) + _offsY*(cos _angle);

_dropStart  = [(_targetPos select 0)+_pointX, (_targetPos select 1)+_pointY, _height];
_dropTarget = [(_targetPos select 0), (_targetPos select 1), 100];
_dropEnd    = [(_targetPos select 0)-_pointX*2, (_targetPos select 1)-_pointY*2, _height];

_ag1spawn = [_dropStart, 0, _aircraft, WEST] call bis_fnc_spawnvehicle;
_ag1air = _ag1spawn select 0;	//the aircraft
_ag1crew = _ag1spawn select 1;	//the units that make up the crew
_ag1 = _ag1spawn select 2;	//the group
{_x allowFleeing 0} forEach units _ag1;

_ag1air flyInHeight 100;
_ag1air setpos [getposATL _ag1air select 0, getposATL _ag1air select 1, _height];

_reldir = [_dropStart, _targetPos] call BIS_fnc_dirTo;
_ag1air setdir _reldir;

supplyDropLatch = false;

_waypoint0 = _ag1 addwaypoint[_dropTarget,0];
_waypoint0 setwaypointtype "Move";
_waypoint0 setWaypointCompletionRadius 10;
_waypoint0 setWaypointStatements ["true", "supplyDropLatch = true;"];

_waypoint1 = _ag1 addwaypoint[_dropEnd,0];
_waypoint1 setwaypointtype "Move";

[_ag1, 1] setWaypointSpeed "FULL";
[_ag1, 1] setWaypointCombatMode "RED";
[_ag1, 1] setWaypointBehaviour "CARELESS";

sleep 4;
_ag1air animateDoor ['Door_1_source', 1];
waitUntil {supplyDropLatch};

// Drop cargo
_playerCount = count playableUnits;
_parachute = "B_Parachute_02_F" CreateVehicle [0,0,0];
_parachute setPos [getPos _ag1air select 0, getPos _ag1air select 1, (getPos _ag1air select 2)-5];
_supplyBox = createVehicle ["Cargonet_01_box_F", [0,0,0], [], 0, "CAN_COLLIDE"];
[_supplyBox, _cargo] remoteExec ["addAction", 0];
_supplyBox attachTo [_parachute, [0,0,0]];
_supplyBox allowDamage false;

waitUntil {getpos _supplyBox select 2<4};
_smoker = "SmokeShellBlue" createVehicle ([getpos _supplyBox select 0, getpos _supplyBox select 1, (getpos _supplyBox select 2)+5]);
detach _supplyBox;

sleep 20;
deletevehicle _ag1air;
{deletevehicle _x} foreach _ag1crew;
