disableSerialization;

_player = _this select 0;

_killPoints = _player getVariable "killPoints";

_hudText = format ["<t size='1.2' color='#ffffff'>%1</t><br/><t size='1.5' color='#dddddd'>%2</t>",(name _player), _killPoints];

1000 cutRsc ["KillPointsHud","PLAIN"];
_ui = uiNameSpace getVariable "KillPointsHud";
_KillPointsHud = _ui displayCtrl 99999;
_KillPointsHud ctrlSetStructuredText parseText _hudText;
_KillPointsHud ctrlCommit 0;
