/*
* Sort backpacks between backpacks, disasembled static guns, disasembled autonomus guns, disasembled drones and disasembled supports
* - expects array of backpack classNames
* - returns [backpacks,disassembledStaticGuns,disassembledAutonomousGuns,disassembledDrones,disassembledSupports]
*/
params [["_backpackArray",[]]];
_backpacks = [];
_disassembledStaticGuns = [];
_disassembledAutonomousGuns = [];
_disassembledDrones = [];
_disassembledSupports = [];
{
	private _item = configFile >> "CfgVehicles" >> _x;
		if (isClass (_item >> "assembleInfo")) then {
			// Guns and drone guns which can be assembled require two items - the gun itself and
			// a mount for the gun.  The required mount must exactly match the gun. This item can be
			// found in the assemblyInfo >> disassemblyTo array of the item's assembleInfo >> assembleTo
			private _assembleTo = getText (_item >> "assembleInfo" >> "assembleTo");
			// If it doesn't assemble into anything, it's a bipod.  These should only be dropped as part
			// of a set of dissassembled guns or drone guns.
			if (_assembleTo != "") then {
				// Only if this assembles into an item for our side should we include it.
				// * Prevents autonomous guns which are enemies from being loot
				// * Reduces the sheer number of essentially duplicate backpack items
				private _itemFaction = getText (_item >> "faction");
				private _factionSide = getNumber (configFile >> "CfgFactionClasses" >> _itemFaction >> "side");
				if (_factionSide == 1) then {
					private _assembledClass = configFile >> "CfgVehicles" >> _assembleTo;
					// Yes, the config name is called "dissasembleTo".  You aren't crazy...
					private _disassembleTo = getArray (_assembledClass >> "assembleInfo" >> "dissasembleTo");
					//[format ["Item %1 assembles to %2 and requires %3", _item, _assembleTo, _disassembleTo], "LIST"] call shared_fnc_log;
					if (getNumber (configFile >> "CfgVehicles" >> _assembleTo >> "isUAV") == 1) then {
							if (getNumber (configFile >> "CfgVehicles" >> _assembleTo >> "hasDriver") == 1) then {
								// This is a UAV/UGV
								_disassembledDrones = _disassembledDrones + [configName _item];
							} else {
								// This is an autonomous gun
								_disassembledAutonomousGuns = _disassembledAutonomousGuns + [configName _item];
								{
									if (_x != configName _item) then {
										//[format ["Requiring support %1", _x], "LIST"] call shared_fnc_log;
										_disassembledSupports pushBackUnique _x;
									};
								} foreach _disassembleTo;
							};
					} else {
						// This is a static gun
						_disassembledStaticGuns = _disassembledStaticGuns + [configName _item];
						{
							if (_x != configName _item) then {
								//[format ["Requiring support %1", _x], "LIST"] call shared_fnc_log;
								_disassembledSupports pushBackUnique _x;
							};
						} foreach _disassembleTo;
					};
				};
			};
		} else {
			_backpacks = _backpacks + [configname _item];
		};
} forEach _backpackArray;
[_backpacks,_disassembledStaticGuns,_disassembledAutonomousGuns,_disassembledDrones,_disassembledSupports]