_player    = _this select 0;
_targetPos = _this select 1;
_aircraft  = _this select 2;
_angle = round random 180;

// Spawn CAS
_center = createCenter sideLogic;
_group = createGroup _center;
_cas = _group createUnit ["ModuleCAS_F", _targetPos , [], 0, ""];
_cas setDir _angle;
_cas setVariable ["vehicle", _aircraft, true];
_cas setVariable ["type", 1, true];
