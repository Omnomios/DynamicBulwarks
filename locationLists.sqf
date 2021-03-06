_zoneMarkers = [];
_zonePositions = [];

{
    if(["bulwark_zone_", _x] call BIS_fnc_inString) then { 
        _zoneMarkers append [_x];
        _zonePositions append [getMarkerPos _x];
        _x setmarkerAlpha 0; 
    };
} foreach allMapMarkers;

List_LocationMarkers = _zoneMarkers;
List_LocationPosistions = _zonePositions;

_allLocations = [];
{
    _allLocations append [locationPosition _x];
} forEach nearestLocations [[0,0,0], ["NameCity", "NameCityCapital", "Airport"], 40000];
List_AllCities = _allLocations;
