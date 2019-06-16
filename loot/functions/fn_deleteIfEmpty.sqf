/**
*  deleteIfEmpty
*
*  deletes the given container if it is empty
*
*  Domain: Client
**/

params ["_container"];

if (
	(magazineCargo _container isEqualTo [])
	&& (weaponCargo _container isEqualTo [])
	&& (backpackCargo _container isEqualTo [])
	&& (itemCargo _container isEqualTo [])
	&& (everyContainer _container isEqualTo [])
	&& (typeOf _container == "WeaponHolderSimulated_Scripted")
) then {
	[_container] remoteExec ["deleteVehicle", 2];
};
