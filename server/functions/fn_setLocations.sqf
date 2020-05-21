#include "..\..\shared\bulwark.hpp"

_zoneMarkers = [];
_markerSetup = false;
{
if (toUpper _x == toUpper worldName) then {
    _markerSetup = true;
    deleteMarker _x;
};
_arr = _x splitString "_";
if("bulwark" in _arr) then {
        _zoneMarkers append [getMarkerPos _x];
        deleteMarker _x;
    };
} foreach allMapMarkers;

_allLocations = [];
{
    _allLocations append [locationPosition _x];
    format ["Added location %1", locationPosition _x] call shared_fnc_log;
} forEach nearestLocations [[0,0,0], ["NameCity", "NameCityCapital", "Airport"], 40000];

_locationParameter = BULWARK_PARAM_BULWARK_POSITION call shared_fnc_getCurrentParamValue;
if (_locationParameter == 1 && count _zoneMarkers != 0 && _markerSetup) then {
    BULWARK_LOCATIONS = _zoneMarkers;
    BULWARK_LOCATIONS_MARKER = true;
}
else
{
    BULWARK_LOCATIONS = _allLocations;
    BULWARK_LOCATIONS_MARKER = false;
};