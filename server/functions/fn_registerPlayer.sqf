params ["_player"];

mainZeus addCuratorEditableObjects [[_player], true];
format ["Player %1 registered", _player] call shared_fnc_log;