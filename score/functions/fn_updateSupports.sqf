_player = player;
_killPoints = _player getVariable "killPoints";

if(!isNil "supportTroops") then {
	if(_killPoints < SCORE_PARATROOP) then {
		[_player, supportTroops] call BIS_fnc_removeCommMenuItem;
        supportTroops = nil;
	};
} else {
	if(_killPoints >= SCORE_PARATROOP) then {
		supportTroops = [_player,"paraDrop"] call BIS_fnc_addCommMenuItem;
	};
};

if(!isNil "supportUAV") then {
	if(_killPoints < SCORE_RECONUAV) then {
		[_player, supportUAV] call BIS_fnc_removeCommMenuItem;
        supportUAV = nil;
	};
} else {
	if(_killPoints >= SCORE_RECONUAV) then {
		supportUAV = [_player,"reconUAV"] call BIS_fnc_addCommMenuItem;
	};
};

if(!isNil "supportBomb") then {
	if(_killPoints < SCORE_AIRSTRIKE) then {
		[_player, supportBomb] call BIS_fnc_removeCommMenuItem;
        supportBomb = nil;
	};
} else {
	if(_killPoints >= SCORE_AIRSTRIKE) then {
		supportBomb = [_player,"airStrike"] call BIS_fnc_addCommMenuItem;
	};
};

if(!isNil "supportRage") then {
	if(_killPoints < SCORE_RAGEPACK) then {
		[_player, supportRage] call BIS_fnc_removeCommMenuItem;
        supportRage = nil;
	};
} else {
	if(_killPoints >= SCORE_RAGEPACK) then {
		supportRage = [_player, "ragePack"] call BIS_fnc_addCommMenuItem;
	};
};
