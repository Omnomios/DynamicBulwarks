_object = _this select 0;
_movePos = _this select 1;

_objectPos = getPosATL (_object);
[_object, false] remoteExec ["enableSimulation", 0];
[_object, [
	(_objectPos select 0) + (_movePos select 0),
	(_objectPos select 1) + (_movePos select 1),
	(_objectPos select 2) + (_movePos select 2)
]] remoteExec ["setPosATL", 0];
[_object, true] remoteExec ["enableSimulation", 0];
