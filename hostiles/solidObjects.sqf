/**
*  solidObjects
*
*  Prevents AI from walking through player placed buildings
*
*  Domain: Server
**/


while {true} do{
  {
    if (!isNull _x) then {
      _playerObject = _x;
      _objRadius = _playerObject getVariable "Radius";
      _objDamage = _playerObject getVariable "Damage";
      _objTotalHP = _playerObject getVariable "TotalHP";
      _objPos = getPos _playerObject;
      _nearAI = _playerObject nearEntities (_objRadius + 2);
      if (_objDamage >= _objTotalHP) then {
        deleteVehicle _playerObject;
        _crater = "Crater" createVehicle _objPos;
      };
      if (_objDamage >= (_objTotalHP / 4) * 3) then {
        _playerObject setDamage 0.8;
      };
      {
        if ((suicideWave && (alive _x)) && (side _x == east)) then {
          _x setDamage 1;
          deleteVehicle _playerObject;
        }else{
          if (side _x == east && (alive _x)) then {
            _isNearObj = _x getVariable "nearObject";
            if (_isNearObj == 0 && (!isNull _playerObject)) then {
              _x setVariable ["nearObject", 1, true];
              [_x, _playerObject] remoteExec ["CreateHostiles_fnc_hosAttkObj", 2];
            };
          };
        };
      } foreach _nearAI;
    };
  }foreach PLAYER_OBJECT_LIST;
}
