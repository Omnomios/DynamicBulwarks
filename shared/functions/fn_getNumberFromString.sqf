#include "..\defines.hpp"
params ["_string"];

private _result = 0;
private _isNegative = false;
private _seenCharacter = false;
private _isInvalid = false;

{
	if (!_isInvalid) then {
		if (_x >= 48 && _x < 58) then {
			_result = _result * 10 + (_x - 48);
			_seenCharacter = true;
		} else {
			if(_x == 45 && _seenCharacter) then {
				_isNegative = true;
			} else {
				[format ["Invalid number string [%1]", _string], LOG_ERR] call shared_fnc_log; 
				_isInvalid = true;
			};
		};
	};
} forEach toArray _string;

if (!_isInvalid) then {
	if (_isNegative) then {
		-_result;
	} else {
		_result;
	};
};