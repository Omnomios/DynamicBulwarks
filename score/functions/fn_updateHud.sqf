disableSerialization;

_player = _this select 0;

_killPoints = _player getVariable "killPoints";

_attackWave = 0;
if(!isNil "attkWave") then {
    _attackWave = attkWave;
};

_hudText = format ["<t size='1.2' color='#ffffff'>%1</t><br/><t size='1.5' color='#dddddd'>%2</t><br/><br/><t size='0.9' color='#cee5d0'>Wave: %3</t>",(name _player), _killPoints, _attackWave];

1000 cutRsc ["KillPointsHud","PLAIN"];
_ui = uiNameSpace getVariable "KillPointsHud";
_KillPointsHud = _ui displayCtrl 99999;
_KillPointsHud ctrlSetStructuredText parseText _hudText;
_KillPointsHud ctrlCommit 0;
