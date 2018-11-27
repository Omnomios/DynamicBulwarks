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
        _playerInvToCheck switchMove "PlayerStand";
        _playerInvToCheck removeItem "Medikit";
        [_playerInvToCheck] remoteExec ["bulwark_fnc_revivePlayer", 2];
      };
    };
  } forEach _allHPs;

  /*if ((count _revivedPlayers) > 0) then {
    for "_i" from 1 to 15 do {
      {
          [_x, 0] remoteExec ["setDamage", 0];
          _nearAi = _x nearEntities 3;
          {
            _x disableAI "ALL";
            _disabledAI pushback _x;
          } forEach _nearAI;
      } forEach _revivedPlayers;
      sleep 1;
    };
    {
      [_x, true] remoteExec ["allowDamage", 0];
    } forEach _revivedPlayers;
    {
      _x enableAI "ALL";
    } forEach _disabledAI;
    _revivedPlayers = [];
    _disabledAI = [];
  }; */
};
