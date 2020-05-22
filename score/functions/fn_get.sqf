/**
*  fn_gets
*
* Gets the killpoints for the current player.  If the points are
* shared, all players have the same value. Otherwise gets the specified
* player's points.
*
*  Domain: Any
**/

params ["_player"];

if (isServer || (_player == player)) then {
    private _killPoints = 0;
    _killPoints = _player getVariable "killPoints";
    if(isNil "_killPoints") then {
        _killPoints = 0;
    };

    //format ["Getting KPs: %1 %2", _player, _killPoints] call shared_fnc_log;

    _killPoints;
} else {
    // Cannot get another player's points from this player
    [_player] remoteExecCall ["killPoints_fnc_get", 2];
};
