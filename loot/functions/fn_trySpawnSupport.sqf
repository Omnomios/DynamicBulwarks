#include "..\..\shared\bulwark.hpp"

// Item to unlock Support Menu (1 spawns every wave until found)
if (!SUPPORTMENU) then {
    ["Spawning support", "LOOT"] call shared_fnc_log;
	private _satRoom = call loot_fnc_getRandomLootRoom;
	if (!isNil "_satRoom") then {
		_satSupport = createVehicle ["Land_SatelliteAntenna_01_F", _satRoom, [], 0, "CAN_COLLIDE"];
		[_satSupport, ["<t color='#ff00ff'>" + "Unlock Support Menu", format ["
			_satSupport = _this select 0;
			_player = _this select 1;
			[_satSupport] remoteExec ['removeAllActions', 0];
			_pointsMulti = (%1 call shared_fnc_getCurrentParamValue);
			if (!SUPPORTMENU) then {
				['TaskAssigned',['Support','Support Menu Unlocked at Bulwark Box']] remoteExec ['BIS_fnc_showNotification', 0];
				['comNoise'] remoteExec ['playSound', 0];
			};
			SUPPORTMENU = true;
			publicVariable 'SUPPORTMENU';
			SatUnlocks = missionNamespace getVariable 'SatUnlocks';
			[_player, (20 * _pointsMulti)] remoteExecCall ['killPoints_fnc_add', 2];
			{
				[_x] remoteExec ['deleteVehicle', 2];
			} forEach SatUnlocks;
		", BULWARK_PARAM_SCORE_KILL]]] remoteExec ["addAction", 0, true];
		SatUnlocks pushBack _satSupport;
		publicVariable 'SatUnlocks';
		mainZeus addCuratorEditableObjects [[_satSupport], true];

        _satSupport;
	} else {
        nil;
    };
} else {
    nil;
};