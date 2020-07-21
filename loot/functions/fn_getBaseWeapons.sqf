/* Function to get empty backpacks
* - expects array of weapon classnames
* - returns unique empty weapon classnames
*/
params [["_weaponsArray",[]]];
_return = [];
{
	//see what the weapon inherits from, if its not scoped out the weapon is probably spawning with attachments and it should take the inheritsFrom weapon instead.
	private _configInherited = inheritsfrom (configfile >> "CfgWeapons" >> _x);
	if (count ([[_configInherited]] call loot_fnc_filterScope) > 0) then
	{
		_return pushBackUnique configName _configInherited;
	}
	else
	{
		_return pushBackUnique _x;
	};
} forEach _weaponsArray;
_return