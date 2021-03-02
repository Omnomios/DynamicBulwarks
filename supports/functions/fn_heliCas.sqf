/**
*  fn_heliCas
*
*  Calls Helicopter CAS to provide support
*
*  Domain: Server
**/
params ["_player", "_aircraft"];
 
 /**
	I DID NOT CREATE A CLENUP FUNCTION FOR THIS SUPPORT
	ALSO, YOU MAY WANT TO MAKE A TIME LIMIT FOR THIS SUPPORT. IT IS A BIT OP
 **/
   
// Spawn CAS 
_position = [[[position _player, 3500]],[]] call BIS_fnc_randomPos; 
_veh = createVehicle [_aircraft,_position, [], 0, "FLY"]; 
createVehicleCrew _veh;
_gunner = gunner _veh;

_wp = (group _veh) addWaypoint [position _player, 0]; 
_wp setWaypointCombatMode "RED";
_wp setWaypointType "SAD"; 
 
while {alive _player && alive _gunner} do {	
	  
	{
		_knownByPilot = (_gunner targetKnowledge _x) select 0;
		_knownByPlayer = (_player targetKnowledge _x) select 0;
        
		if(!_knownByPilot && _knownByPlayer) then {
			(group _gunner) reveal [_x, (_player knowsAbout _x)]; 
		};
		if(_knownByPilot && !_knownByPlayer) then {
			(group _player) reveal [_x, (_gunner knowsAbout _x)]; 
		};		
	} 
	forEach allUnits;

	sleep 3;
	if(isNull assignedTarget _gunner) then {
		_wp = (group _veh) addWaypoint [position _player, 0]; 
		_wp setWaypointCombatMode "RED";
		_wp setWaypointType "SAD"; 
	};
};
