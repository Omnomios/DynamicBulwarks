/**
*  fn_updateHud
*
*  Hud values have changed, update Hud
*
*  Domain: Client
**/

if (!isDedicated) then {
    disableSerialization;
    _player = player;

    _killPoints = _player getVariable "killPoints";
    if(isNil "_killPoints") then {
        _killPoints = 0;
    };

    _attackWave = 0;
    if(!isNil "attkWave") then {
        _attackWave = attkWave;
    };

	_respawnTickets = [west] call BIS_fnc_respawnTickets;
	if(isNil "_respawnTickets" || _respawnTickets < 0) then {
        _respawnTickets = 0;
    };

    _hudText = format ["<t size='1.2' color='#ffffff'>%1</t><br/><t size='1.5' color='#dddddd'>%2</t><br/><t size='0.9' color='#cee5d0'>Wave: %3</t><br/><t size='0.9' color='#cee5d0'>Tickets: %4</t>",(name _player), _killPoints, _attackWave, _respawnTickets];

    1000 cutRsc ["KillPointsHud","PLAIN"];
    _ui = uiNameSpace getVariable "KillPointsHud";
    _KillPointsHud = _ui displayCtrl 99999;
    _KillPointsHud ctrlSetStructuredText parseText _hudText;
    _KillPointsHud ctrlCommit 0;
};
