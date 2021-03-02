/**
*  fn_support
*
*  Event handler for supports/communications menu
*
*  Domain: Client/Event
**/

_player   = _this select 0;
_target   = _this select 1;
_type     = _this select 2;
_vehicle = _this select 3;

switch (_type) do {
    case ("paraTroop"): {
        [_player, _target, PARATROOP_COUNT, _vehicle, PARATROOP_CLASS] call supports_fnc_paraTroop;
    };
    case ("reconUAV"): {
        [_player, getPos _player, _vehicle] call supports_fnc_reconUAV;
    };
    case ("airStrike"): {
        [_player, _target, _vehicle] call supports_fnc_airStrike;
    };
    case ("ragePack"): {
        // Ragepack is a local effect so it needs to be executed locally
        [] remoteExec ["supports_fnc_ragePack", _player];
    };
    case ("armaKart"): {
		[_player] call supports_fnc_armaKart;
    };
    case ("mindConGas"): {
		[_player, _target] call supports_fnc_mindConGas;
    };
    case ("droneControl"): {
		[_player, _target] call supports_fnc_droneControl;
    };
    case ("mineField"): {
		[_player, _target] call supports_fnc_mineField;
    };
    case ("telePlode"): {
		[_player] call supports_fnc_telePlode;
    };
    case ("artillery"): {
        [_player, _target, _vehicle] call supports_fnc_artillery;
    };
    case ("artilleryBarrage"): {
        [_player, _target, _vehicle, 35, 5] call supports_fnc_artillery;
    };    
};
