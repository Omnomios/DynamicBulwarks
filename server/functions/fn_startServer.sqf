#include "..\..\shared\bulwark.hpp"

// variable to prevent players rejoining during a wave
playersInWave = [];
publicVariable "playersInWave";

startLoadingScreen ["Entering defense perimeter..."];

//init phase
["<t size = '.5'>Loading lists.<br/>Please wait...</t>", 0, 0, 10, 0] remoteExec ["BIS_fnc_dynamicText", 0];
private _hostileFunctions = [ //could make more efficent init phase with loadingscreen
  "createWave",
  "waveTypes"
];
{
	[] call (compileFinal (preprocessFile format ["hostiles\%1.sqf", _x]));
} forEach _hostileFunctions;

// Do these need to be done in ExecVM?
"Setting params and lists" call shared_fnc_log;

call server_fnc_setParams;

call BIS_fnc_reviveInit;
call server_fnc_setLocations;

call compile preprocessFileLineNumbers  "presets\init_preset.sqf";

call loot_fnc_generateLootLists;

call loot_fnc_setLootTypes;

call compile preprocessFileLineNumbers  "hostiles\lists.sqf";

["<t size = '.5'>Creating Base...</t>", 0, 0, 30, 0] remoteExec ["BIS_fnc_dynamicText", 0];

_basepoint = call compile preprocessFileLineNumbers "bulwark\createBase.sqf";

["<t size = '.5'>Ready</t>", 0, 0, 0.5, 0] remoteExec ["BIS_fnc_dynamicText", 0];

publicVariable "bulwarkBox";
publicVariable "PARATROOP_CLASS";
publicVariable "BULWARK_SUPPORTITEMS";
publicVariable "BULWARK_BUILDITEMS";
publicVariable "PLAYER_STARTWEAPON";
publicVariable "PLAYER_STARTMAP";
publicVariable "PLAYER_STARTNVG";
publicVariable "PISTOL_HOSTILES";
publicVariable "DOWN_TIME";
publicVariable "RESPAWN_TICKETS";
publicVariable "RESPAWN_TIME";
publicVariable "PLAYER_OBJECT_LIST";
publicVariable "MIND_CONTROLLED_AI";
publicVariable "SCORE_RANDOMBOX";
publicVariable "KILLPOINTS_MODE";
publicVariable "magLAUNCHER";
publicVariable "magASSAULT";
publicVariable "magSMG";
publicVariable "magSNIPER";
publicVariable "magMG";
publicVariable "magHANDGUN";

//determine if Support Menu is available
_supportParam = (BULWARK_PARAM_SUPPORT_MENU call shared_fnc_getCurrentParamValue);
if (_supportParam == 1) then {
  SUPPORTMENU = false;
}else{
  SUPPORTMENU = true;
};
publicVariable 'SUPPORTMENU';

//Determine team damage Settings
_teamDamageParam = (BULWARK_PARAM_TEAM_DAMAGE call shared_fnc_getCurrentParamValue);
if (_teamDamageParam == 0) then {
  TEAM_DAMAGE = false;
}else{
  TEAM_DAMAGE = true;
};
publicVariable 'TEAM_DAMAGE';

//determine if hitmarkers appear on HUD
HITMARKERPARAM = (BULWARK_PARAM_HUD_POINT_HITMARKERS call shared_fnc_getCurrentParamValue);
publicVariable 'HITMARKERPARAM';

// Broadcast the starting killpoints and update the HUD for everyone
[west, RESPAWN_TICKETS] call BIS_fnc_respawnTickets;
call killPoints_fnc_init;

// Set time
_dayTimeHours = DAY_TIME_TO - DAY_TIME_FROM;
_randTime = floor random _dayTimeHours;
_timeToSet = DAY_TIME_FROM + _randTime;
setDate [2018, SEASON, 21, _timeToSet, 0];
setTimeMultiplier TIME_MULTIPLIER;

"Starting mission loop" call shared_fnc_log;

gameStarted = true;
publicVariable "gameStarted";

endLoadingScreen;

[] spawn server_fnc_missionLoop;
[] execVM "hostiles\clearStuck.sqf";
[] execVM "area\areaEnforcement.sqf";
//[] execVM "hostiles\solidObjects.sqf";
[] execVM "hostiles\moveHosToPlayer.sqf";

"StartGame complete" call shared_fnc_log;
