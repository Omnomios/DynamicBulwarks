while {true} do {
    _allHCs = entities "HeadlessClient_F";
    _allHPs = allPlayers - _allHCs;

    // Teleport players back to the box
    {
        if ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 1.1) then {
            _newLoc = [bulwarkBox] call bulwark_fnc_findPlaceAround;
            _x setPosASL _newLoc;
        };
    } foreach _allHPs;

    // Warn the player that they're too far drom the box
    {
        if ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 0.85) then {
            ["Warning: Leaving mission area!",0, 0.1] remoteExec ["BIS_fnc_dynamicText", _x];
        };
    } foreach _allHPs;

    sleep 0.01;
};
