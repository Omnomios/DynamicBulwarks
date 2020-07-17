if (isServer) then {
    [] call factions_fnc_getAllFactions params ["_hostileFactions","_lootFactions"];
    factionOptions = _hostileFactions;
    publicVariable "factionOptions";
    lootFactionOptions = _lootFactions;
    publicVariable "lootFactionOptions";
    [] call loot_fnc_getModTags;
};