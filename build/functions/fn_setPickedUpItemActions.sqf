params ["_object", "_caller"];

[format ["Setting picked up item actions on player: %1 for object %2", _caller, _object], "BUILD"] call shared_fnc_log;

removeAllActions _object;

_caller addAction [
	"<t color='#00ffff'>Drop Object (Snap To Ground)</t>",
	'[_this select 3, _this select 1, true] call build_fnc_place;',
	_object
];

_caller addAction [
	"<t color='#00ffff'>Place Object (Floating)</t>",
	'[_this select 3, _this select 1, false] call build_fnc_place;',
	_object
];

