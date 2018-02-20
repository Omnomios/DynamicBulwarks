_location = select 0;

sleep 0.5;
_attGroupBand = group _player;
for ("_i") from 1 to _unitCount do {
    _banditSpaned = objNull;
    _infBandit = selectRandom _classList;
    systemChat _infBandit;
    _infBandit createUnit [[0,0,0], _attGroupBand, "_banditSpaned = this", 1];
    if (isNull _banditSpaned) then {hint "falied to spawn";} else {
        _banditSpaned setPos [getPos _agVehicle vectorAdd [0,0,-2]];
        _banditSpaned addBackpack "B_Parachute";
        _banditSpaned doMove _targetPos;
    };
    sleep 0.3;
};
