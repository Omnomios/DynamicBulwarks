_object = _this select 0;
_caller = _this select 1;

_objDir = getdir _object;
[_object, _objDir] remoteExec ["setDir", 0];
