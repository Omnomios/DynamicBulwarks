_object  = _this select 0;
_isHeld = _object getVariable "buildItemHeld";
_loopCount = 0;
_foundAIArr = [];
while {!(_object isEqualTo objNull) && !_isHeld} do {
    if (_loopcount >= 20) then {
        _loopCount = 0;
        _foundAIArr = [];
    };
    _loopCount = _loopCount + 1;
    _objRadius = (_object getVariable "Radius") + 1;
    _nearAI = _object nearEntities _objRadius;
    _isPlaced = _object getVariable "buildItemHeld";
    {
      if (suicideWave && (alive _x) && (side _x == east)) then {
        _x setDamage 1;
        deleteVehicle _object;
      }else{
        if (side _x == east && !(_x in _foundAIArr) && (alive _x)) then {
          doStop _x;
          _x disableAI "MOVE";
          _aiDir = _object getDir _x;
          _x setDir _aiDir;
          _aiGoToPos = _object getRelPos [random [-10,0,-10], _aiDir];
          _x setBehaviour "CARELESS";
          _x setUnitPos "UP";
          _x playActionNow "FastF";
          _x forceSpeed 6;
          _safePos = [_aiGoToPos, 0, 8, 2, 0] call BIS_fnc_findSafePos;
          _x enableAI "MOVE";
          _x doMove _safePos;
          _foundAIArr pushBack _x;
        };
      };
    } foreach _nearAI;
    sleep 0.1;
};
