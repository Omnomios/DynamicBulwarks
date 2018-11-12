_object = _this select 0;
_movePos = _this select 1;
_caller = _this select 2;

_callerPos = getPosATL (_caller);
_objectPos = getPosATL (_object);
[_object, false] remoteExec ["enableSimulation", 0];
[_object, [
	(_objectPos select 0) + (_movePos select 0),
	(_objectPos select 1) + (_movePos select 1),
	(_objectPos select 2) + (_movePos select 2)
]] remoteExec ["setPosATL", 0];
[_object, true] remoteExec ["enableSimulation", 0];
sleep 0.1;
_newCallerPos = getPosATL (_caller);
if ((_newCallerPos select 2) > (_callerPos select 2)) then {
	[_object, _objectPos] remoteExec ["setPosATL", 0];
};
