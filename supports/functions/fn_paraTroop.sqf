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

_dropStart = [(_targetPos select 0)+_pointX, (_targetPos select 1)+_pointY, _height];
_dropEnd   = [(_targetPos select 0)-_pointX*2, (_targetPos select 1)-_pointY*2, _height];

// Spawn aircraft
[_dropStart, _dropEnd, _height, "NORMAL", _aircraft, WEST] call BIS_fnc_ambientFlyby;
_dropVehc = (nearestObjects [_dropStart, [_aircraft], 40]) select 0;

sleep 8;
// Open cargo door
_dropVehc animateDoor ['Door_1_source', 1];
sleep 1;

_attGroupBand = group _player;
for ("_i") from 1 to _unitCount do {
    _banditSpaned = objNull;
    _infBandit = selectRandom _classList;
    systemChat _infBandit;
    _infBandit createUnit [[0,0,0], _attGroupBand, "_banditSpaned = this", 1];
    if (isNull _banditSpaned) then {hint "falied to spawn";} else {
        _banditSpaned setPos [getPos _dropVehc select 0, getPos _dropVehc select 1, (getPos _dropVehc select 2)-2];
        _banditSpaned addBackpack "B_Parachute";
        _banditSpaned doMove _targetPos;
    };
    sleep 0.3;
};

// Close cargo door
_dropVehc animateDoor ['Door_1_source', 0];
