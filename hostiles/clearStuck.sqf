AIStuckCheckArray = [];

while {true} do {
  {
    if ((side _x == east) && (alive _x)) then {
      _AIunit = _x;
      AIStuckCheckArray pushBack [_x, getPos _x];
    };
  } forEach allUnits;
  sleep 4;
  {
    _AIunit = _x select 0;
    _AIpos = _x select 1;
    if ((_AIpos isEqualTo (getPos _AIunit))) then {
      _AIunit = _x select 0;
      _allHCs = entities "HeadlessClient_F";
      _allHPs = allPlayers - _allHCs;
      nearestPlayerDistance = 9999;
      {
        _distToPlayer = (_AIunit distance2d _x);
        if (_distToPlayer < nearestPlayerDistance) then {
          nearestPlayer = _x
        };
      } forEach _allHPs;
      _safePos = [nearestPlayer, 0, 10, 2] call BIS_fnc_findSafePos;
      _AIunit doMove _safePos;
    };
  }forEach AIStuckCheckArray;
  sleep 4;
  {
    _AIunit = _x select 0;
    _AIpos = _x select 1;
    if ((_AIpos isEqualTo (getPos _AIunit)) && (west knowsAbout _AIunit < 3.5)) then { //
      deleteVehicle _AIunit;
    };
  }forEach AIStuckCheckArray;
  AIStuckCheckArray = [];
};
