/**
*  loot/lists
*
*  Populates global arrays with spawnable loot classes
*
*  Domain: Server
**/

_hats = [];
_uniforms = [];
_vests = [];
_primaries = [];
_secondaries = [];
_launchers = [];
_optics = [];
_railAttach = [];
_items = [];
_mines = [];
_backpacks = [];
_glasses = [];
_faces = [];
_grenades = [];
_count =  count (configFile >> "CfgWeapons");
for "_x" from 0 to (_count-1) do {
	_weap = ((configFile >> "CfgWeapons") select _x);
	if (isClass _weap) then {
		if (getnumber (_weap >> "scope") == 2) then {
			if (isClass (_weap >> "ItemInfo")) then {
				_infoType = (getnumber (_weap >> "ItemInfo" >> "Type"));
				switch (_infoType) do {
					case 605: {_hats = _hats + [configName _weap];};
					case 801: {_uniforms = _uniforms + [configName _weap];};
					case 701: {_vests = _vests + [configName _weap];};
					case 201: {_optics = _optics + [configName _weap];};
					case 301: {_railAttach = _railAttach + [configName _weap];};
					case 601: {_items = _items + [configName _weap];};
					case 620: {_items = _items + [configName _weap];}; // Toolkit
					case 619: {_items = _items + [configName _weap];}; // Medikit
					case 621: {_items = _items + [configName _weap];}; // UAV terminal
					case 616: {_items = _items + [configName _weap];}; // NVG
					case 401: {_items = _items + [configName _weap];}; // First Aid Kit
				};
			};
			if (!isClass (_weap >> "LinkedItems")) then {
				if (count(getarray (_weap >> "magazines")) !=0 ) then {
					_type = getnumber (_weap >> "type");
					switch (_type) do {
						case 1: {_primaries = _primaries + [configName _weap];};
						case 3: {_secondaries = _secondaries + [configName _weap];};
						case 4: {_launchers = _launchers + [configName _weap];};
					};
                };
            };
        };
    };
};

_count =  count (configFile >> "CfgVehicles");
for "_x" from 0 to (_count-1) do {
    _item=((configFile >> "CfgVehicles") select _x);
    if (isClass _item) then {
        if (getnumber (_item >> "scope") == 2) then {
            if (gettext (_item >> "vehicleClass") == "Backpacks") then {
                _backpacks = _backpacks + [configname _item]
            };
        };
    };
};

_count =  count (configFile >> "CfgGlasses");
for "_x" from 0 to (_count-1) do {
    _item=((configFile >> "CfgGlasses") select _x);
    if (isClass _item) then {
        if (getnumber (_item >> "scope") == 2) then {
            _glasses = _glasses + [configName _item];
        };
    };
};
_count =  count (configFile >> "CfgFaces" >> "Man_A3");
for "_x" from 0 to (_count-1) do {
    _item=((configFile >> "CfgFaces" >> "Man_A3") select _x);
    if (isClass _item) then {_faces = _faces + [configName _item];};
};

_count =  count (configFile >> "CfgMagazines");
for "_x" from 0 to (_count-1) do {
    _item=((configFile >> "CfgMagazines") select _x);
	if (isClass _item) then {
		if(getNumber (_item >> "value") == 5) then {
			if(["mine", getText (_item >> "displayName")] call BIS_fnc_inString) then {
				_mines = _mines + [configName _item];
			}
		};
	};
};

_count =  count (configFile >> "CfgMagazines");
for "_x" from 0 to (_count-1) do {
    _item=((configFile >> "CfgMagazines") select _x);
	if (isClass _item) then {
		if(getNumber (_item >> "type") == 16 || getNumber (_item >> "type") == 256) then {
			if(["grenade", getText (_item >> "displayName")] call BIS_fnc_inString && !(["smoke", getText (_item >> "displayName")] call BIS_fnc_inString)) then {
				_grenades = _grenades + [configName _item];
			}
		};
	};
};

List_Hats = [] + _hats;
List_Uniforms = [] + _uniforms;
List_Vests = [] + _vests;
List_Backpacks = [] + _backpacks;
List_Primaries = [] + _primaries;
List_Secondaries = [] + _secondaries;
List_Launchers = [] + _launchers;
List_Optics = [] + _optics + _railAttach;
List_Items = [] + _items + ['ItemGPS','ItemCompass','ItemMap', 'ItemWatch', 'ItemRadio'];
List_Mines = [] + _mines;
List_Glasses = [] + _glasses;
List_Faces = [] + _faces;
List_Grenades = [] + _grenades;

List_AllWeapons = List_Primaries + List_Secondaries + List_Launchers;
List_AllClothes = List_Hats + List_Uniforms + List_Glasses;
List_AllGrenades = List_Grenades;
