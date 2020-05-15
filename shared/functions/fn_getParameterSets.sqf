#include "..\defines.hpp"

private _paramSets = [];

{
    _paramSets pushBack [_x select 0, PARAMSET_TYPE_BUILTIN];
} forEach (call shared_fnc_getDefaultParameterSets);

{
    _paramSets pushBack [_x, PARAMSET_TYPE_CUSTOM];
} forEach (call shared_fnc_getSavedParameterSets);

_paramSets;