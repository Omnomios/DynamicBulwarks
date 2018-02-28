_revivedPlayers = [];

while {true} do {
  _allHCs = entities "HeadlessClient_F";
  _allHPs = allPlayers - _allHCs;

  //check if unconscious players have medkit
  //revivedPlayers = [];
  {
    _playerInvToCheck = _x;
    if ((lifeState _x) == "INCAPACITATED") then {
      _playerItems = items _x;
      if ("Medikit" in _playerItems) then {
        [_playerInvToCheck, false] remoteExec ["setUnconscious", 0];
        [ "#rev", 1, _playerInvToCheck ] remoteExecCall ["BIS_fnc_reviveOnState", _playerInvToCheck];
        _playerInvToCheck allowDamage false;
        _playerInvToCheck removeItem "Medikit";
        _revivedPlayers pushBack _playerInvToCheck;
        sleep 0.01;
      };
    };
  } forEach _allHPs;

  if ((count _revivedPlayers) > 0) then {
    sleep 15;
    {
        _x allowDamage true;
    } forEach _revivedPlayers;
    _revivedPlayers = [];
  };
};
