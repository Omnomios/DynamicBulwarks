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

_dropStart  = [(_targetPos select 0)+_pointX, (_targetPos select 1)+_pointY, _height];
_dropTarget = [(_targetPos select 0), (_targetPos select 1), 200];
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

paraTroopLatch = false;

_waypoint0 = _ag1 addwaypoint[_dropTarget,0];
_waypoint0 setwaypointtype "Move";
_waypoint0 setWaypointCompletionRadius 10;
_waypoint0 setWaypointStatements ["true", "paraTroopLatch = true;"];

_waypoint1 = _ag1 addwaypoint[_dropEnd,0];
_waypoint1 setwaypointtype "Move";

[_ag1, 1] setWaypointSpeed "FULL";
[_ag1, 1] setWaypointCombatMode "RED";
[_ag1, 1] setWaypointBehaviour "CARELESS";

_ag1air animateDoor ['Door_1_source', 1];
waitUntil {paraTroopLatch};

_attGroupBand = group _player;
for ("_i") from 1 to _unitCount do {
    _banditSpaned = objNull;
    _infBandit = selectRandom _classList;
    systemChat _infBandit;
    _infBandit createUnit [[0,0,0], _attGroupBand, "_banditSpaned = this", 1];
    if (isNull _banditSpaned) then {hint "falied to spawn";} else {
        _banditSpaned setPos [getPos _ag1air select 0, getPos _ag1air select 1, (getPos _ag1air select 2)-2];
        _banditSpaned addBackpack "B_Parachute";
        _banditSpaned doMove _targetPos;
    };
    sleep 0.3;
};

sleep 20;
deletevehicle _ag1air;
{deletevehicle _x} foreach _ag1crew;
