/**
*  fn_supplyDrop
*
*  Calls VTOL to drop a box with the action definend by _cargo attached
*
*  Domain: Server
*
* NOTE: _targetPos should be a ground-level position
**/
params ["_targetPos", "_cargo", "_aircraft"];

_angle = round random 360;
_height = supportAircraftWaypointHeight;
_radius = 1000; // Start 1km away
_pointX = _radius * (cos _angle);
_pointY = _radius * (sin _angle);

_dropStart  = _targetPos vectorAdd [_pointX, _pointY, _height];
_dropTarget = [(_targetPos select 0), (_targetPos select 1), 100];
_dropEnd    = _targetPos vectorAdd [-_pointX*2, -_pointY*2, _height];

_reldir = [_dropStart, _targetPos] call BIS_fnc_dirTo;
_agSpawn = [_dropStart, _reldir, _aircraft, WEST] call bis_fnc_spawnvehicle;
_agVehicle = _agSpawn select 0;	//the aircraft
_agCrew = _agSpawn select 1;	//the units that make up the crew
_ag = _agSpawn select 2;	//the group
{_x allowFleeing 0} forEach units _ag;

_agVehicle flyInHeight supportAircraftFlyInHeight;
// _agVehicle setpos [getposATL _agVehicle select 0, getposATL _agVehicle select 1, _height];
_agVehicle setVectorUp [0, 0, 1];
_vel = velocity _agVehicle;
_dir = direction _agVehicle;
_speed = supportAircraftSpeed;
_agVehicle setVelocity [
	(_vel select 0) + (sin _dir * _speed), 
	(_vel select 1) + (cos _dir * _speed), 
	(_vel select 2)
];
supplyDropLatch = false;

// Set the radius to be a percentage of the Bulwark radius - the drop will happen somewhere
// within this area
private _supplyDropRadius = BULWARK_RADIUS * LOOT_SUPPLYDROP;
_waypoint0 = _ag addwaypoint[_dropTarget,_supplyDropRadius];
_waypoint0 setwaypointtype "Move";

_waypoint0 setWaypointCompletionRadius 5;
_waypoint0 setWaypointStatements ["true", "supplyDropLatch = true;"];

_waypoint1 = _ag addwaypoint[_dropEnd,0];
_waypoint1 setwaypointtype "Move";

[_ag, 1] setWaypointSpeed "FULL";
[_ag, 1] setWaypointCombatMode "RED";
[_ag, 1] setWaypointBehaviour "CARELESS";

sleep 4;
_agVehicle animateDoor ['Door_1_source', 1];
waitUntil {supplyDropLatch};

// Drop cargo
private _parachutePos = (getPosATL _agVehicle) vectorAdd [0, 0, -8]; // Start 8 meters below the plane, to avoid collisions
_parachute = createVehicle ["B_Parachute_02_F", _parachutePos, [], 0, "NONE"];
_supplyBox = createVehicle ["Land_WoodenCrate_01_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_supplyBox attachTo [_parachute, [0,0,0]];
_supplyBox allowDamage false;
[_supplyBox, _cargo] remoteExec ["addAction", 0, true];



waitUntil {getpos _supplyBox select 2<4};
_smoker = "SmokeShellBlue" createVehicle (getpos _supplyBox vectorAdd [0,0,5]);
detach _supplyBox;

sleep 20;
deletevehicle _agVehicle;
{deletevehicle _x} foreach _agCrew;
