/**
*  fn_init
*
*  Initialize the score system
*
*  Domain: Server
**/

#include "..\..\shared\bulwark.hpp"

if (KILLPOINTS_MODE == KILLPOINTS_MODE_SHARED) then {
  // Add initial killpoints for everyone by virtue of adding it to the first player
  [allPlayers select 0, BULWARK_PARAM_START_KILLPOINTS call shared_fnc_getCurrentParamValue] call killPoints_fnc_add;
} else {
  {
    // Current result is saved in variable _x
    [_x, BULWARK_PARAM_START_KILLPOINTS call shared_fnc_getCurrentParamValue] call killPoints_fnc_add;
  } forEach allPlayers;
};
