// Do lobby-specific server initialization here, such as calculating
// default parameters and options based on loaded mods.
startLoadingScreen ["Preparing the trap..."];
[] call factions_fnc_getAllFactions params ["_hostileFactions","_lootFactions"];
factionOptions = _hostileFactions;
publicVariable "factionOptions";
lootFactionOptions = _lootFactions;
publicVariable "lootFactionOptions";
endLoadingScreen;