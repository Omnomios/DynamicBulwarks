params ["_object", "_caller"];

if (!(player call build_fnc_isHoldingObject)) then {
	[player, _object] remoteExec ["build_fnc_doPickup", 2];
} else {
	[format ["<t size='0.6' color='#ff3300'>You're already carrying an object!</t>"], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;
};
