params ["_object", "_destinationPos", "_caller"];

_object enableSimulation false;
_object setPosATL _destinationPos;
_object enableSimulation true;