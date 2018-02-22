waitUntil {!isNil "bullwarkBox"};
_player = _this select 0;
_player setPosASL ([bullwarkBox] call bulwark_fnc_findPlaceAround);
