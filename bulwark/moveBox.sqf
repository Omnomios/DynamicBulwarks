_emptyCrate = _this select 0;
_caller = _this select 1;
_pickupAction = _this select 2;
_emptyCrate attachTo [_caller, [0,2,0.05], "Pelvis"];
[_emptyCrate, _pickupAction] remoteExec ["removeAction", 0];
[_caller, ["drop", "bulwark\dropBox.sqf", _emptyCrate]] remoteExec ["addAction", 0];
