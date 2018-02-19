_emptyCrate = _this select 0;
_dropAction = _this select 2;

detach _emptyCrate;
_emptyCrate removeAction _dropAction;
[_emptyCrate, ["Pickup", "loot\moveBox.sqf"]] remoteExec ["addAction", 0];

