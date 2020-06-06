_lootBoxRoom = call loot_fnc_getRandomLootRoom;
if (!isNil "_lootBoxRoom") then {
    lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 4];
    publicVariable "lootBox";
    [lootBox, ["<t color='#00ffff'>" + "Pickup", { _this call bulwark_fnc_moveBox; }]] remoteExec ["addAction", 0, true];
    [lootBox, [
        format ["<t color='#FF0000'>Spin the box! %1p</t>", SCORE_RANDOMBOX], "
            lootBoxPos    = getPos lootBox;
            lootBoxPosATL = getPosATL lootBox;
            lootBoxDir    = getDir lootBox;
            _player = _this select 1;
            _points = _player getVariable 'killPoints';
            if(_points >= SCORE_RANDOMBOX) then {
                [_player, SCORE_RANDOMBOX] remoteExec ['killPoints_fnc_spend', 2];
                [[lootBoxPos, lootBoxPosATL, lootBoxDir], 'loot\spin\main.sqf'] remoteExec ['execVM', 2];
            };
        "
    ]] remoteExec ["addAction", 0, true];

    mainZeus addCuratorEditableObjects [[lootBox], true];

    lootBox;
} else {
	nil;
};

