params ["_object", "_caller"];

removeAllActions _caller;

_object addAction [
	'<t color="#ff0000">Remove Object</t>',
	'[_this select 0, _this select 1] call build_fnc_sell;',
	'', 1, false, false, 'true', 'true', 5
];


_object addAction [
	'<t color="#00ffff">Move Up</t>',
	'[_this select 0, _this select 3, _this select 1] call build_fnc_move;',
	[0,0,0.5],2,false,false,'true','true',5
];

_object addAction [
	'<t color="#00ff00">Move Down</t>',
	'[_this select 0, _this select 3, _this select 1] call build_fnc_move;',
	[0,0,-0.5],2,false,false,'true','true',5
];

_object addAction [
	'<t color="#ffffff">Pickup</t>',
	'[_this select 0, _this select 1] call build_fnc_pickup;',
	[0,0,0.5],2,false,false,'true','true',5
];

_object addAction [
	'<t color="#ffff00">Reset Rotation</t>',
	'[_this select 0, _this select 1] call build_fnc_reset;',
	[0,0,0.5],2,false,false,'true','true',5
];

mainZeus addCuratorEditableObjects [[_object], true];
