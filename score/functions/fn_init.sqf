/**
*  fn_init
*
*  Initialize the score system
*
*  Domain: Server
**/

#include "..\..\shared\bulwark.hpp"

private _justPlayers = call BIS_fnc_listPlayers;
if (KILLPOINTS_MODE == KILLPOINTS_MODE_SHARED) then {
  // Add initial killpoints for everyone by virtue of adding it to the first player
  format ["Adding initial points to player %1 SHARED", _justPlayers select 0] call shared_fnc_log;
  [_justPlayers select 0, BULWARK_PARAM_START_KILLPOINTS call shared_fnc_getCurrentParamValue] call killPoints_fnc_add;
} else {
  {
    // Current result is saved in variable _x
    format ["Adding initial points to player %1 PRIVATE", _justPlayers select 0] call shared_fnc_log;
    [_x, BULWARK_PARAM_START_KILLPOINTS call shared_fnc_getCurrentParamValue] call killPoints_fnc_add;
  } forEach _justPlayers;
};
