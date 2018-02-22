_probeResult = _this call bulwark_fnc_probeBox;
if(!(_probeResult select 0)) exitWith {
	[false, [0,0,0]];
};

_top    = _probeResult select 1;
_right  = _probeResult select 2;
_bottom = _probeResult select 3;
_left   = _probeResult select 4;

_centre = [
	[_left select 0, _right select 0, 0.5, 0] call BIS_fnc_lerp,
	[_top select 1, _bottom select 1, 0.5, 0] call BIS_fnc_lerp,
	((_top select 2) + (_bottom select 2) + (_left select 2) + (_right select 2)) / 4
];

[true, _centre];
