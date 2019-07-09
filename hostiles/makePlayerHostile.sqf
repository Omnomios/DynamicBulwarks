_player = _this select 0;

_enemyGroup = createGroup east;
[_player] joinSilent _enemyGroup;
_player setPos [0,0,0];

private _targetSet = false;
private _targetUnit = nil;

while {!_targetSet} do {
    ["<t size = '.5'>Waiting for hostile unit to spawn...</t>", 0, 0, 0.5, 0] remoteExec ["BIS_fnc_dynamicText", _player];
    if(count unitArray > 0) then {
        _candidate = selectRandom unitArray;
        if(alive _candidate) then {
            if(!isPlayer _candidate) then {
                _targetSet = true;
                _targetUnit = _candidate;
            };
        };
    };
    sleep 0.3;
};

selectPlayer _targetUnit;
_unit = _player;
deleteVehicle _unit;
