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
      if ((_x findNearestEnemy _x) == objNull) then {
        _x setBehaviour "CARELESS";
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
      _doMovePos = getPos goToPlayer;

      // If it's a vehicle move to a place 15m from the player.
      // TODO: check to see if that spot is empty
      if(thisNPC isKindOf "LandVehicle") then {
        _dir = thisNPC getDir goToPlayer;
                _doMovePos = goToPlayer getPos [20, _dir];
      };

      if (gotoPlayerDistance > 15) then {
        thisNPC doMove _doMovePos;
      } else {
        thisNPC doMove [(_doMovePos select 0) + (random [-7.5, 7.5, 0]), (_doMovePos select 1) + (random [-7.5, 7.5, 0]), _doMovePos select 2];
      };
    };
  } foreach allUnits;
  sleep 10;
};
