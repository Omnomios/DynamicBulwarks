_spawnObject = _this select 0;
_dir = _this select 1;
_objectPos = getPosASL _spawnObject vectorAdd [0,0,0.15];

_edges = [];

for ("_i") from 0 to 3 do {
	_relPos = [_objectPos, 10, _dir + (90 * _i)] call BIS_fnc_relPos;
	_rayIntersect = lineIntersectsSurfaces [_objectPos, _relPos, _spawnObject, _spawnObject, true, 1, "GEOM", "NONE"];
	if (count _rayIntersect == 0) exitWith {};
	_hit = _rayIntersect select 0;
	_edge = _hit select 0;
	_edges append [_edge];
};

if(count _edges < 4) exitWith {
    [false,[0,0,0],[0,0,0],[0,0,0],[0,0,0],0,0]
};

_top    = _edges select 0;
_right  = _edges select 1;
_bottom = _edges select 2;
_left   = _edges select 3;

_w = (_right select 0) - (_left select 0);
_h = (_top select 1) - (_bottom select 1);

[true, _top, _right, _bottom, _left, _w, _h];
