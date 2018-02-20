_player    = _this select 0;
_targetPos = _this select 1;
_unitCount = _this select 2;
_aircraft  = _this select 3;
_classList = _this select 4;

_angle = round random 180;
_height = 300;
_offsX = 0;
_offsY = 1000;
_pointX = _offsX*(cos _angle) - _offsY*(sin _angle);
_pointY = _offsX*(sin _angle) + _offsY*(cos _angle);

_dropStart  = _targetPos vectorAdd [_pointX, _pointY, _height];
_dropTarget = [(_targetPos select 0), (_targetPos select 1), 200];
_dropEnd    = _targetPos vectorAdd [-_pointX*2, -_pointY*2, _height];;

_targetSmoker = "SmokeShellGreen" createVehicle (_targetPos);

_agSpawn = [_dropStart, 0, _aircraft, WEST] call bis_fnc_spawnvehicle;
_agVehicle = _agSpawn select 0;	//the aircraft
_agCrew = _agSpawn select 1;	//the units that make up the crew
_ag = _agSpawn select 2;	//the group
{_x allowFleeing 0} forEach units _ag;

_agVehicle flyInHeight 100;
_agVehicle setpos [getposATL _agVehicle select 0, getposATL _agVehicle select 1, _height];

_relDir = [_dropStart, _targetPos] call BIS_fnc_dirTo;
_agVehicle setdir _relDir;

paraTroopLatch = false;

_waypoint0 = _ag addwaypoint[_dropTarget, 0];
_waypoint0 setwaypointtype "Move";
_waypoint0 setWaypointCompletionRadius 5;
_waypoint0 setWaypointStatements ["true", "paraTroopLatch = true;"];

_waypoint1 = _ag addwaypoint[_dropEnd, 0];
_waypoint1 setwaypointtype "Move";

[_ag, 1] setWaypointSpeed "FULL";
[_ag, 1] setWaypointCombatMode "RED";
[_ag, 1] setWaypointBehaviour "CARELESS";

_agVehicle animateDoor ['Door_1_source', 1];
waitUntil {paraTroopLatch};

_location = getPos _agVehicle;
[_location] remoteExec ['hint', 0];

sleep 0.5;
_attGroupBand = group _player;
for ("_i") from 1 to 3 do {
    _banditSpaned = objNull;
    _infBandit = selectRandom _classList;
    systemChat _infBandit;
    _infBandit createUnit [[0,0,0], _attGroupBand, "_banditSpaned = this", 1];
    if (isNull _banditSpaned) then {hint "falied to spawn";} else {
        _banditSpaned setPos [_location vectorAdd [0,0,-2]];
        _banditSpaned addBackpack "B_Parachute";
        _banditSpaned doMove _targetPos;
    };
    sleep 0.3;
};

sleep 20;
deletevehicle _agVehicle;
{deletevehicle _x} foreach _agCrew;
