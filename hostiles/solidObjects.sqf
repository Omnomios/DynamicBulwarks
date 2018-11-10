/**
*  solidObjects
*
*  Prevents AI from walking through player placed buildings
*
*  Domain: Server
**/


while {true} do{
  allAiNearObjects = [];
  {
    if (!isNull _x) then {
      _playerObject = _x;
      _objRadius = _x getVariable "Radius";
      _nearAI = _x nearEntities _objRadius;
      allAiNearObjects + _nearAI;
      {
        if (suicideWave && (alive _x) && (side _x == east)) then {
          _x setDamage 1;
          deleteVehicle _playerObject;
        }else{
          if (side _x == east) then {
            _aiDir = _playerObject getDir _x;
            _aiGoToPos = _playerObject getRelPos [random [10,15,20], _aiDir];
            _x setBehaviour "CARELESS";
            _x setUnitPos "UP";
            _safePos = [_aiGoToPos, 0, 8, 2, 0] call BIS_fnc_findSafePos;
            _x doMove _safePos;
          };
        };
      } foreach _nearAI;
    };
  }foreach PLAYER_OBJECT_LIST;
  sleep 0.3;
}
