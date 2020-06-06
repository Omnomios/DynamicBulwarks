/**
*  moveBox
*
*  Actor for the bulwark "Pickup" action menu item
*
*  Domain: Client
**/
params ["_emptyCrate", "_caller", "_pickupAction"];

if (!(player call build_fnc_isHoldingObject)) then {
    {[_emptyCrate, _x] remoteExec ["disableCollisionWith", 0];} forEach playableUnits;

    _emptyCrate attachTo [_caller, [0,2,0.05], "Pelvis"];
    [_emptyCrate, _pickupAction] remoteExec ["removeAction", 0];
    private _action = player addAction ["<t color='#00ffff'>" + "Drop", { _this call bulwark_fnc_dropBox; }, _emptyCrate];
    [player, "bulwark_fnc_dropBox", [nil, player, _action, _emptyCrate]] call build_fnc_registerHeldObject;
} else {
	[format ["<t size='0.6' color='#ff3300'>You're already carrying an object!</t>"], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;
};
