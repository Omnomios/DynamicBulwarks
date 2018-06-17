_object = _this select 0;
_movePos = _this select 1;

_objectPos = getPos (_object);
_object setPos [
	(_objectPos select 0) + (_movePos select 0), 
	(_objectPos select 1) + (_movePos select 1),
	(_objectPos select 2) + (_movePos select 2)
];