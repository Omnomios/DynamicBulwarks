_emptyCrate = _this select 0;
_caller = _this select 1;
_pickupAction = _this select 2;
_emptyCrate enableSimulationGlobal false;
_emptyCrate attachTo [_caller, [0,1,0], "Pelvis"];
_emptyCrate removeAction _pickupAction;
[_emptyCrate, ["drop", "loot\dropBox.sqf"]] remoteExec ["addAction", 0];

