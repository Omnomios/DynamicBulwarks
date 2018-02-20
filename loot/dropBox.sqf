_emptyCrate = _this select 3;
_dropAction = _this select 2;
_playerAction = _this select 1;

detach _emptyCrate;
_playerAction removeAction _dropAction;
[_emptyCrate, ["Pickup", "loot\moveBox.sqf"]] remoteExec ["addAction", 0];
