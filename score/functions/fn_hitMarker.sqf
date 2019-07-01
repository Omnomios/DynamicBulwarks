/**
*  fn_hitMarker
*
*  Add to the local hitmarker array for rendering
*
*  Domain: Client
**/

_unit = _this select 0;
_value = _this select 1;
_colour = _this select 2;
_appended = false;

_markerScrub = [];
{
    if(_x select 4) then {
        _markerScrub pushBack _x;
        // It's the same unit
        if(_unit == _x select 2) then {
            _x set [1, (_x select 1) + _value]; // Add values
            _x set [3, 0]; // Reset age
            _appended = true;
        };
    };
} forEach hitMarkers;

hitMarkers = _markerScrub;

if(!_appended) then {
    hitMarkers pushBack [
        (getPos _unit) vectorAdd [random 0.5, random 0.5, random 0.5],
        _value,
        _unit,
        0,
        true,
        _colour
    ];
};
