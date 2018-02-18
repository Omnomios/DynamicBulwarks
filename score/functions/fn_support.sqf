_player   = _this select 0;
_type     = _this select 1;
_aircraft = _this select 2;

_requiredPoints = 0;
_humanText = "";
switch (_type) do {
    case ("paraTroop"): {
        _requiredPoints = SCORE_PARATROOP;
        _humanText = "paratroopers"
    };
    case ("reconUAV"): {
        _requiredPoints = SCORE_RECONUAV;
        _humanText = "recon UAV"
    };
};

if(_player getVariable "killPoints" >= _requiredPoints) then {
    [_player, _requiredPoints] call killPoints_fnc_spend;
    switch (_type) do {
        case ("paraTroop"): {
            [_player, getPos _player, PARATROOP_COUNT, _aircraft, PARATROOP_CLASS] call supports_fnc_paraTroop;
        };
        case ("reconUAV"): {
            [_player, getPos _player, _aircraft] call supports_fnc_reconUAV;
        };
    };
} else {
    [format ["<t size='0.6' color='#ff3300'>%1 points required to call %2</t>", _requiredPoints, _humanText], -0.6, -0.35] remoteExec ["BIS_fnc_dynamicText", _player];
};
