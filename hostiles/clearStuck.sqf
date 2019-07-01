AIstuckcheck = 0;

while {true} do {
  if (east countSide allUnits == 0) then {
    AIStuckCheckArray = [];
    AIstuckcheck = -1;
  };
  if (AIstuckcheck == 0) then {
    _allHCs = entities "HeadlessClient_F";
    _allHPs = allPlayers - _allHCs;
    {
      if ((side _x == east) && (alive _x)) then {
        _AIunit = _x;
        nearestPlayerDistance = 9999;
        {
          _distToPlayer = (_AIunit distance2d _x);
          if (_distToPlayer < nearestPlayerDistance) then {
            nearestPlayerDistance = _distToPlayer;
            nearestPlayerPos = getPos _x;
          };
        } forEach _allHPs;
        AIStuckCheckArray pushBack [_x, nearestPlayerDistance, nearestPlayerPos];
      };
    } forEach allUnits;
  };
  AIstuckcheck = AIstuckcheck + 1;
  sleep(1);
  if (AIstuckcheck == 30) then {
    _allHCs = entities "HeadlessClient_F";
    _allHPs = allPlayers - _allHCs;
    {
      _AItoCheck = _x select 0;
      _OriginalDistToPlayer = _x select 1;
      _OriginalPlayerPos = _x select 2;
      nearestPlayerDistance = 9999;
      {
        _playerHostDistance = _AItoCheck distance2d _x;
        if ((_playerHostDistance < nearestPlayerDistance)) then {
          nearestPlayerDistance = _playerHostDistance;
        };
      } forEach _allHPs;
      _newDistToPlayerPos = _AItoCheck distance2d _OriginalPlayerPos;
      if ((alive _AItoCheck) && (_newDistToPlayerPos > (_OriginalDistToPlayer - 15))) then {
        if (((west knowsAbout _AItoCheck) < 3.5) && (nearestPlayerDistance > 35) && (_AItoCheck distance bulwarkBox > 20)) then {
          if (isNull objectParent _AItoCheck) then {
            deleteVehicle _AItoCheck;
          }else{
            if (nearestPlayerDistance >= BULWARK_RADIUS) then {
              objectParent _AItoCheck setDamage 1;
            };
          };
        };
      };
    } forEach AIStuckCheckArray;
    AIstuckcheck = 0;
    AIStuckCheckArray = [];
  };
};
