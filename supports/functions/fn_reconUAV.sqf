/**
*  fn_reconUAV
*
*  Spawns UAV and runs special unit position to marker script while it lives
*
*  Domain: Client
**/
params ["_player", "_targetPos", "_aircraft"];

_angle = round random 180;
_height = 100;
_offsX = 0;
_offsY = 300;
_pointX = _offsX*(cos _angle) - _offsY*(sin _angle);
_pointY = _offsX*(sin _angle) + _offsY*(cos _angle);

_dropStart = [(_targetPos select 0)+_pointX, (_targetPos select 1)+_pointY, _height];
_dropEnd   = [(_targetPos select 0)-_pointX*2, (_targetPos select 1)-_pointY*2, _height];

_UAV = ([_targetPos, 0, _aircraft, WEST] call BIS_fnc_spawnVehicle) select 0;
createVehicleCrew (_UAV);

_uavGroup = createGroup west;
[_UAV] join _uavGroup ;

_wp = _uavGroup addWaypoint [_player, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE_L";
_wp setWaypointLoiterRadius 10;

hosMrks = [];
_curWave = attkWave;
while {_curWave == attkWave} do {

    if (currentWaypoint _uavGroup != _wp select 1) then {_uavGroup setCurrentWaypoint _wp;};

    _wp setWaypointPosition [position _player, 0];

    {
        if ((side _x) == east) then {
            _mrkrName = format ["hos%1", _x];
            _hosMkr = createMarker [_mrkrName, getPos _x];
            _mrkrName setMarkerType "hd_dot";
            _mrkrName setMarkerColor "ColorRed";
            hosMrks pushback _mrkrName;
        };
    } forEach allUnits;
    sleep 2;
    { deleteMarker _x } forEach hosMrks;
    if(!alive _UAV) exitWith {};
};

_UAV setDamage 1;
