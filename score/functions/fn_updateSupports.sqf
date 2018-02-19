_player = _this select 0;
_killPoints = _player getVariable "killPoints";

if(!isNil "supportTroops") then {
	if(_killPoints < SCORE_PARATROOP) then {
		[player, supportTroops] call BIS_fnc_removeCommMenuItem;
        supportTroops = nil;
	};
} else {
	if(_killPoints >= SCORE_PARATROOP) then {
		supportTroops = [player,"paraDrop"] call BIS_fnc_addCommMenuItem;
	};
};

if(!isNil "supportUAV") then {
	if(_killPoints < SCORE_RECONUAV) then {
		[player, supportUAV] call BIS_fnc_removeCommMenuItem;
        supportUAV = nil;
	};
} else {
	if(_killPoints >= SCORE_RECONUAV) then {
		supportUAV = [player,"reconUAV"] call BIS_fnc_addCommMenuItem;
	};
};

if(!isNil "supportBomb") then {
	if(_killPoints < SCORE_AIRSTRIKE) then {
		[player, supportBomb] call BIS_fnc_removeCommMenuItem;
        supportBomb = nil;
	};
} else {
	if(_killPoints >= SCORE_AIRSTRIKE) then {
		supportBomb = [player,"airStrike"] call BIS_fnc_addCommMenuItem;
	};
};
