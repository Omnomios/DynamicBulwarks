/**
*  solidObjects
*
*  Prevents AI from walking through player placed buildings: No longer used. Replaced by bulwark\solidobject.sqf
*
*  Domain: Server
**/


while {true} do{
  {
    if (!isNull _x) then {
      _playerObject = _x;
      _objRadius = (_x getVariable "Radius") + 1;
      _nearAI = _x nearEntities _objRadius;
      {
        if (suicideWave && (alive _x) && (side _x == east)) then {
          _x setDamage 1;
          deleteVehicle _playerObject;
        }else{
          if (side _x == east) then {
            _x disableAI "MOVE";
            _aiDir = _playerObject getDir _x;
            _aiGoToPos = _playerObject getRelPos [random [10,15,20], _aiDir];
            _x setBehaviour "CARELESS";
            _x setUnitPos "UP";
            _safePos = [_aiGoToPos, 0, 8, 2, 0] call BIS_fnc_findSafePos;
            _x enableAI "MOVE";
            _x doMove _safePos;
          };
        };
      } foreach _nearAI;
    };
  }foreach PLAYER_OBJECT_LIST;
  sleep 0.3;
}
