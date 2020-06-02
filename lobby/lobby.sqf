/**
*  lobby
*
*  Handles the lobby portion of the scenario
*
*  Domain: Server
**/
#include "..\shared\defines.hpp"

waitUntil { !isNil "factionOptions" };

if (player == leader (group player)) then {
	[format ["Loading parameters from player: %1", player], "LOBBY"] call shared_fnc_log;
	private _selectedParameterSet = call shared_fnc_loadSelectedParameterSet;
	CurrentBulwarkParams = [_selectedParameterSet, PARAMSET_TYPE_CUSTOM] call shared_fnc_loadParameterSet;

	if (isNil "CurrentBulwarkParams") then {
		CurrentBulwarkParams = [_selectedParameterSet, PARAMSET_TYPE_BUILTIN] call shared_fnc_loadParameterSet;
	};

	if (isNil "CurrentBulwarkParams") then {
		CurrentBulwarkParams = +(call shared_fnc_getDefaultParams);
	};

	publicVariable "CurrentBulwarkParams";
};

//
// Lead Survivor actions
//

lobbyCrate addAction [
	"Set mission parameters", // title
	{createDialog "bulwarkParams_Dialog"}, // script
	nil, // arguments
	3, // priority
	false, // showWindow
	true, // hideOnUse
	"", // shortCut
	"player == leader (group player)" // Confition
];

lobbyCrate addAction [
	"<t color='#00FF00'>GO! GO! GO!</t>", // title
	{call lobby_fnc_startGame},
	nil, // arguments
	2, // priority
	false, // showWindow
	true, // hideOnUse
	"", // shortCut
	"player == leader (group player)" // Confition
];

lobbyCrate addAction [
	"<t color='#FF0000'>ABORT MISSION</t>", 
	{"Abort" call BIS_fnc_endMissionServer},
	nil,
	1,
	false, // showWindow
	true, // hideOnUse
	"", // shortCut
	"player == leader (group player)" // Condition
];


//
// Everyone else
//
lobbyCrate addAction [
	"<t color='#FF0000'>You aren't the lead survivor</t>", // title
	{ hint "Wait for the lead survivor to prepare the mission" },
	nil,
	1,  
	true, // showWindow
	true, // hideOnUse
	"", // shortCut
	"player != leader (group player)" // condition
];
