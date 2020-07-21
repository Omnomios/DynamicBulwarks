/* Function to get empty backpacks
* - expects array of backpack classnames
* - returns unique empty backpack classnames
*/
params [["_backpacksArray",[]]];
private _return = [];
{
	//see what the backpack inherits from, if its not scoped out the backpack is probably spawning with gear and it should take the inheritsFrom backpack instead.
	private _configInherited = inheritsfrom (configfile >> "CfgVehicles" >> _x);
	if (count ([[_configInherited]] call loot_fnc_filterScope) > 0) then
	{
		_return pushBackUnique configName _configInherited;
	}
	else
	{
		_return pushBackUnique _x;
	};
} forEach _backpacksArray;
_return