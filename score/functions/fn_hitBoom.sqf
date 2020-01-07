/**
*  fn_hitBoom
*
*  Event handler for explosive objects
*
*  Domain: Event
**/

if (isServer) then {
_object = _this select 0;
_dmg = _this select 2;
_instigator = _this select 3;

//get position of current object
_objPos = getPos _object;
_explosion = createVehicle ["R_TBG32V_F",_objPos, [],0,"CAN_COLLIDE"];
deleteVehicle _object;

};