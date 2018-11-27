while {true} do {
  _allHCs = entities "HeadlessClient_F";
  _allHPs = allPlayers - _allHCs;
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
};
