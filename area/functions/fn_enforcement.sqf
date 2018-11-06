/**
*  fn_enforcement
*
*  reset player when leaving area
*
*  Domain: Server
**/

_player = _this select 0;

_leaving = true;

while {_leaving} do {
	_dist = _player distance2D bulwarkCity;
	switch true do {

		// If player is WAYYY outside the bounds. Move them to the bulwark
		case (_dist > BULWARK_RADIUS * 2): {
			_newLoc = [bulwarkBox] call bulwark_fnc_findPlaceAround;
			_player setPosASL _newLoc;
		};

		// If player is trying to leave, bounce them back.
		case (_dist > BULWARK_RADIUS * 1.1): {
			_dir = bulwarkCity getDir _player;
			_newLoc = bulwarkCity getPos [(BULWARK_RADIUS * 1.1)-8, _dir];
			_player setPosASL _newLoc;
			[_player, "teleportHit"] remoteExec ["sound_fnc_say3DGlobal", 0];
			["DynamicBlur", 200, [10]] remoteExec ["area_fnc_createBlur", _player];
		};

		// Warn the player that they're too far from the centre
		case (_dist > BULWARK_RADIUS * 0.99): {
			["<t color='#ff0000'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _player];
		};
		case (_dist > BULWARK_RADIUS * 0.95): {
			["<t color='#ffff00'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _player];
		};
		case (_dist > BULWARK_RADIUS * 0.9): {
			["<t color='#ffffff'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _player];
		};

		default {
			_leaving = false
		};
	};
	sleep 1;
};
