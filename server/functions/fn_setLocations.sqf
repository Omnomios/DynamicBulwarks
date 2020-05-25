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

private _locationTypes = (BULWARK_PARAM_LOCATIONS call shared_fnc_getCurrentParamValue);
format ["Locations: %1", _locationTypes] call shared_fnc_log;
if (count _locationTypes == 0) then {
    _locationTypes = ["NameCityCapital", "NameCity", "Airport"];
};

_allLocations = [];
{
    private _groundPosition = locationPosition _x;
    _groundPosition set [2, getTerrainHeightASL [_groundPosition select 0, _groundPosition select 1]];
    _allLocations append [_groundPosition];
    format ["Added location %1", _groundPosition] call shared_fnc_log;
} forEach nearestLocations [[0,0,0], _locationTypes, 40000];

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