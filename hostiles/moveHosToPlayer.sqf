/**
*  movHosToPlayer
*
*  Moves AI to Player
*
*  Domain: Server
**/

waitUntil {!isNil "attkWave"};

While {true} do {
  // Get all human players in this wave cycle
  _allHCs = entities "HeadlessClient_F";
  _allHPs = allPlayers - _allHCs;
  //Set AI Behaviour and delete if they are far away from bulwark
  {
    if (side _x == east) then {
      _x setBehaviour "CARELESS";
      if (_x distance bulwarkBox > 1500) then {
        deleteVehicle _x;
      };
      _aiUnit = _x;
      {
          if ((_x distance _aiUnit) < 20) then {
            _AIunit setVariable ["movingToSafePos", false];
          };
      } forEach _allHPs;
    };
  } foreach allUnits;
  //Move AI to Players
  {
    if (side _x == east) then {
      _movingToSafePos = _x getVariable "movingToSafePos";
      if (!(_movingToSafePos)) then {
        _aiUnit = _x;
        _distToPlayer = 9999;

        {
          if (alive _x) then {
            _aiDistToPlayer = _aiUnit distance _x;
            if (_aiDistToPlayer < _distToPlayer) then {
              _distToPlayer = _aiDistToPlayer;
              playerToCheck = _x;
            };
          };
        } forEach _allHPs;

        _objsNearPlayer = [];

        {
          _objDistToPlayer = playerToCheck distance _x;
          if (_objDistToPlayer < 20) then {
            _objsNearPlayer pushBack _x;
          };
        }forEach PLAYER_OBJECT_LIST;

        //if player near object move AI to object
        _aiUnit disableAI "MOVE";

        if (count _objsNearPlayer == 0) then {
          _aiUnit enableAI "MOVE";
          _aiUnit reveal [playerToCheck, 4];
        }else{
          _aiUnit forgetTarget playerToCheck;
          _nearAiDistToObj = 9999;

          {
            _aiDistToObj = _aiUnit distance _x;
            if (_aiDistToObj < _nearAiDistToObj) then {
              _nearAiDistToObj = _aiDistToObj;
              GoToObj = _x;
            };
          } forEach _objsNearPlayer;

          _aiDir = GoToObj getDir _aiUnit;
          _radius = GoToObj getVariable "Radius";
          _aiGoToPos = GoToObj getPos [_radius, _aiDir];
          _aiGoToPos = [_aiGoToPos, 0, 2, 2] call BIS_fnc_findSafePos;
          _disToObj = _aiUnit distance GoToObj;

          if (_disToObj > _radius + 1.9) then {
            _aiUnit enableAI "MOVE";
            _aiUnit doMove _aiGoToPos;
          };

        };
      };
    };
  } foreach allUnits;

  //build array of unit positions
  AIStuckCheckArray = [];
  {
    if ((side _x == east) && (alive _x)) then {
      _AIunit = _x;
      AIStuckCheckArray pushBack [_x, getPos _x];
    };
  } forEach allUnits;
  sleep 4;

  //move to a safe position if stuck
  {
    _AIunit = _x select 0;
    _AIpos = _x select 1;
    if ((_AIpos distance (getPos _AIunit)) < 1) then {
      _AIunit = _x select 0;
      _allHCs = entities "HeadlessClient_F";
      _allHPs = allPlayers - _allHCs;
      nearestPlayerDistance = 9999;
      {
        _AIunit forgetTarget _x;
        _distToPlayer = (_AIunit distance2d _x);
        if (_distToPlayer < nearestPlayerDistance) then {
          nearestPlayer = _x
        };
      } forEach _allHPs;
      _safePos = [nearestPlayer, 0, 10, 2] call BIS_fnc_findSafePos;
      _AIunit doMove _safePos;
      _AIunit setVariable ["movingToSafePos", true];
    };
  }forEach AIStuckCheckArray;
  sleep 4;

  //move to an even safer position if still stuck
  {
    _AIunit = _x select 0;
    _AIpos = _x select 1;
    if ((_AIpos distance (getPos _AIunit)) < 1) then {
      _AIunit = _x select 0;
      _allHCs = entities "HeadlessClient_F";
      _allHPs = allPlayers - _allHCs;
      nearestPlayerDistance = 9999;
      {
        _AIunit forgetTarget _x;
        _distToPlayer = (_AIunit distance2d _x);
        if (_distToPlayer < nearestPlayerDistance) then {
          nearestPlayer = _x
        };
      } forEach _allHPs;
      _safePos = [nearestPlayer, 0, 20, 2] call BIS_fnc_findSafePos;
      _AIunit doMove _safePos;
      _AIunit setVariable ["movingToSafePos", true];
    };
  }forEach AIStuckCheckArray;
  sleep 4;

  //delete if stuck
  {
    _AIunit = _x select 0;
    _AIpos = _x select 1;
    _allHCs = entities "HeadlessClient_F";
    _allHPs = allPlayers - _allHCs;
    {
      _distToPlayer = (_AIunit distance2d _x);
      nearestPlayerDistance = 9999;
      if (_distToPlayer < nearestPlayerDistance) then {
        nearestPlayer = _x
      };
    } forEach _allHPs;
    nearestPlrObject = 10;
    {
      _distToObj = (_AIunit distance2d _x);
      _nearestObjectDistance = 9999;
      if (_distToObj < _nearestObjectDistance) then {
        nearestPlrObject = _distToObj;
      };
    }foreach PLAYER_OBJECT_LIST;
    _playerDist = _AIunit distance nearestPlayer;
    if (((_AIpos distance (getPos _AIunit)) < 1) && (west knowsAbout _AIunit < 3.5) && (_playerDist > 25) && (nearestPlrObject > 5)) then {
      deleteVehicle _AIunit;
    };
  }forEach AIStuckCheckArray;
  AIStuckCheckArray = [];
};
