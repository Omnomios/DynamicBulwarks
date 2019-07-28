/**
*  solidObjects
*
*  Moves AI to Player
*
*  Domain: Server
**/

While {true} do {
  // Get all human players in this wave cycle
  _allHCs = entities "HeadlessClient_F";
  _allHPs = allPlayers - _allHCs;
  //Set AI Behaviour
  {
    if (side _x == east) then {
      _x allowFleeing 0;
      if ((_x findNearestEnemy _x) == objNull || suicideWave) then {
        _x playActionNow "FastF";
        _x setBehaviour "CARELESS";
        _x setUnitPos "UP";
        _x forceSpeed 6;
      } else {
        _x setBehaviour "AWARE";
      };
    };
  } foreach allUnits;
  //Move AI to Players
  {
    if (side _x == east) then {
      thisNPC = _x;
      gotoPlayerDistance = 9999;

      _aiTargets = [];
      {
        if ((alive _x) && (lifeState _x) != "INCAPACITATED") then {
          _aiTargets pushBack _x;
        };
      } forEach _allHPs;

      {
        _playerHostDistance = (getPos thisNPC) distance _x;
        if ((_playerHostDistance < gotoPlayerDistance) && (alive _x)) then {
          goToPlayer = _x;
          gotoPlayerDistance = _playerHostDistance;
        };
      } forEach _aiTargets;

      //Move inft to within 15 meters of player and move Armor to 15 - 55 meters of player
      _playerPos = getPos goToPlayer;
      _doMovePos = getPos goToPlayer;
      if (isNull objectParent thisNPC) then {
        _doMovePos = [goToPlayer, 1, 15] call BIS_fnc_findSafePos;
        _doMovePos = [_doMovePos select 0, _doMovePos select 1, _playerPos select 2];
      }else{
        if (suicideWave) then {
          _doMovePos = getPos goToPlayer;
        }else{
          _doMovePos = [goToPlayer, 15, 55, 0.5, 0, 30] call BIS_fnc_findSafePos;
          _doMovePos = [_doMovePos select 0, _doMovePos select 1, 0];
        };
      };
      thisNPC doMove _doMovePos;
    };
  } foreach allUnits;
  sleep 15;
};
