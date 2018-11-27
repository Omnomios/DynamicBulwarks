/**
*  fn_hosAttkObj
*
*  Gets units to attack nearby player objects
*
*  Domain: Server
**/

_unit = _this select 0;
_playerObject = _this select 1;
_unitPos = getPos _unit;

if (!(isNull _playerObject)) then {
  _objDamage = _playerObject getVariable "Damage";
  _damageObj = _objDamage + 1;
  _playerObject setVariable ["Damage", _damageObj, true];
  [_unit, "AwopPercMstpSgthWnonDnon_Throw"] remoteExec ["switchMove", 0];
  if (!(isNull _playerObject)) then {
    [_playerObject, "vehicle_collision"] remoteExec ["sound_fnc_say3DGlobal", 0];
  };
  for "_i" from 1 to 15 do{
    sleep 0.07;
    _unit setPos _unitPos;
  };

  _unit setVariable ["nearObject", 0, true];
};
