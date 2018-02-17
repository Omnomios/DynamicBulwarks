_hats = [];
_uniforms = [];
_vests = [];
_primaries = [];
_secondaries = [];
_launchers = [];
_backpacks = [];
_glasses = [];
_faces = [];
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
				};
			};
			if (!isClass (_weap >> "LinkedItems")) then {
				if (count(getarray (_weap >> "magazines")) !=0 ) then {
					_type = getnumber (_weap >> "type");
					if (_type == 1) then {
                        _primaries = _primaries + [configName _weap];
                    } else {
                        if (_type == 2) then {
                            _secondaries = _secondaries + [configName _weap];
                        } else {
                            if (_type == 4) then { _launchers = _launchers + [configName _weap]; };
                        };
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

List_Hats = [] + _hats;
List_Uniforms = [] + _uniforms;
List_Vests = [] + _vests;
List_Backpacks = [] + _backpacks;
List_Primaries = [] + _primaries;
List_Secondaries = [] + _secondaries;
List_Launchers = [] + _launchers;
List_Glasses = [] + _glasses;
List_Faces = [] + _faces;

List_AllWeapons = List_Primaries + List_Secondaries + List_Launchers;
List_AllClothes = List_Hats + List_Uniforms + List_Glasses;
List_AllStorage = List_Vests + List_Backpacks;
