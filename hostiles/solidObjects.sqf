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
      _playerObject = _x;
      _nearAI = _x nearEntities 3;
      allAiNearObjects + _nearAI;
      {
        if (side _x == east) then {
          _aiDir = _playerObject getDir _x;
          _aiGoToPos = _playerObject getRelPos [random [10,15,20], _aiDir];
          _x setBehaviour "CARELESS";
          _x setUnitPos "UP";
          _safePos = [_aiGoToPos, 0, 8, 2, 0] call BIS_fnc_findSafePos;
          _x doMove _safePos;
        };
      } foreach _nearAI;
  }foreach PLAYER_OBJECT_LIST;
  sleep 0.3;
}
