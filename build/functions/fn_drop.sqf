_object = _this select 0;
_caller = _this select 1;
_action = _this select 2;

detach _object;

{
	[_object, _x] remoteExec ['enableCollisionWith', 0];
} forEach playableUnits;

_caller removeAction _action;

_object setVehiclePosition [_object, [], 0, 'CAN_COLLIDE'],

[
	_object, 
	[
		'<t color="#ff0000">Remove Object</t>', 
		'[_this select 0, _this select 1] call build_fnc_sell;', 
		'', 1, false, false, 'true', 'true', 5
	]
] remoteExec ['addAction', 0];

[
	_object, 
	[
		'<t color="#00ffff">Move Up</t>', 
		'[_this select 0, _this select 3] call build_fnc_move;',
		[0,0,0.5],2,false,false,'true','true',5
	]
] remoteExec ['addAction', 0];

[
	_object, 
	[
		'<t color="#00ff00">Move Down</t>', 
		'[_this select 0, _this select 3] call build_fnc_move;',
		[0,0,-0.5],2,false,false,'true','true',5
	]
] remoteExec ['addAction', 0];

[
	_object, 
	[
		'<t color="#ffffff">Pickup</t>', 
		'[_this select 0, _this select 1] call build_fnc_pickup;',
		[0,0,0.5],2,false,false,'true','true',5
	]
] remoteExec ['addAction', 0];