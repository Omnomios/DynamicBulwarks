params ["_object", "_caller"];

[format ["Player %1 picked up item %2", _caller, _object], "BUILD"] call shared_fnc_log;
if (!(player getVariable "buildItemHeld")) then {
	[player, _object] remoteExec ["build_fnc_doPickup", 2];
} else {
	[format ["<t size='0.6' color='#ff3300'>You're already carrying an object!</t>"], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;
};
