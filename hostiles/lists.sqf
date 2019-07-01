/**
*  hostiles/lists
*
*  Populates global arrays with various unit types
*
*  Domain: Server
**/

_zombieSpider = [];
_zombiePlayer = [];
_zombieCrawler = [];
_zombieFast = [];
_zombieMedium = [];
_zombieSlow = [];
_zombieBoss = [];
_zombieWalker = [];

_count =  count (configFile >> "CfgVehicles");
for "_x" from 0 to (_count-1) do {
    _item=((configFile >> "CfgVehicles") select _x);
    if (isClass _item) then {
        if (getnumber (_item >> "scope") == 2) then {
            if (gettext (_item >> "vehicleClass") == "Ryanzombiesspider") then {
                _zombieSpider = _zombieSpider + [configname _item]
            };
            if (gettext (_item >> "vehicleClass") == "Ryanzombiesplayer") then {
                _zombiePlayer = _zombiePlayer + [configname _item]
            };
            if (gettext (_item >> "vehicleClass") == "RyanzombiesCrawler") then {
                _zombieCrawler = _zombieCrawler + [configname _item]
            };
            if (gettext (_item >> "vehicleClass") == "Ryanzombiesfast") then {
                _zombieFast = _zombieFast + [configname _item]
            };
            if (gettext (_item >> "vehicleClass") == "Ryanzombiesslow") then {
                _zombieSlow = _zombieSlow + [configname _item]
            };
            if (gettext (_item >> "vehicleClass") == "Ryanzombiesmedium") then {
                _zombieMedium = _zombieMedium + [configname _item]
            };
            if (gettext (_item >> "vehicleClass") == "Ryanzombiesboss") then {
                _zombieBoss = _zombieBoss + [configname _item]
            };
            if (gettext (_item >> "vehicleClass") == "Ryanzombieswalker") then {
                _zombieWalker = _zombieWalker + [configname _item]
            };
        };
    };
};

List_ZombieSpider = _zombieSpider;
List_ZombiePlayer = _zombiePlayer;
List_ZombieCrawler = _zombieCrawler;
List_ZombieFast = _zombieFast;
List_ZombieMedium = _zombieMedium;
List_ZombieSlow = _zombieSlow;
List_ZombieBoss = _zombieBoss;
List_ZombieWalker = _zombieWalker;

_bandits = [];
_groupConfig = configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "BanditCombatGroup";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_bandits pushback getText (_item >> "vehicle");
    };
};
List_Bandits = _bandits;

_bandits = [];
_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_EV_VCG" >> "vclocalInfantry" >> "vc_fourmancell";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_bandits pushback getText (_item >> "vehicle");
    };
};

_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_EV_VCG" >> "vclocalInfantry" >> "vc_assaultSquad";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_bandits pushback getText (_item >> "vehicle");
    };
};
_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_EV_VCG" >> "vclocalInfantry" >> "vc_rifleteam";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_bandits pushback getText (_item >> "vehicle");
    };
};
List_Bandits = _bandits;
//List_Bandits = ['CFP_I_TUAREG_Grenadier_01','CFP_I_TUAREG_Rifleman_AT_01','CFP_I_TUAREG_Team_Leader_01','CFP_I_TUAREG_Explosive_Specialist_01','CFP_I_TUAREG_Explosive_Specialist_01'];

_paraBandits = [];
_groupConfig = configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "ParaCombatGroup";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_paraBandits pushback getText (_item >> "vehicle");
    };
};
List_ParaBandits = _paraBandits;

// _eastSoldier = [];
// _groupConfig = configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad";
// _count = count (_groupConfig);
// for "_x" from 0 to (_count-1) do {
    // _item=((_groupConfig) select _x);
    // if (isClass _item) then {
		// _eastSoldier pushback getText (_item >> "vehicle");
    // };
// };
// List_OPFOR = _eastSoldier;


_eastSoldier = [];
_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_EV_VC" >> "vcmainforceInfantry" >> "vc_mainweaponsquadtwo";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_eastSoldier pushback getText (_item >> "vehicle");
    };
};

_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_EV_VC" >> "vcmainforceInfantry" >> "vc_mainriflesquadtwo";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_eastSoldier pushback getText (_item >> "vehicle");
    };
};

_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_EV_VC" >> "vcmainforceInfantry" >> "vc_mainreconsquad";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_eastSoldier pushback getText (_item >> "vehicle");
    };
};
List_OPFOR = _eastSoldier;

_indSoldier = [];
_groupConfig = configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=(_groupConfig select _x);
    if (isClass _item) then {
		_indSoldier pushback getText (_item >> "vehicle");
    };
};
List_INDEP = _indSoldier;

_natoSoldier = [];
_groupConfig = configfile >> "CfgGroups" >> "West" >> "UNSUNG_AUS" >> "SpecOps" >> "uns_SAS_Patrol_1";
_count = count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=(_groupConfig select _x);
    if (isClass _item) then {
		_natoSoldier pushback getText (_item >> "vehicle");
    };
};
List_NATO = _natoSoldier;

// _viper = [];
// _groupConfig = configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_ViperTeam";
// _count =  count (_groupConfig);
// for "_x" from 0 to (_count-1) do {
    // _item=((_groupConfig) select _x);
    // if (isClass _item) then {
		// _viper pushback getText (_item >> "vehicle");
    // };
// };
// List_Viper = _viper;

_viper = [];
// _groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_E_NVA" >> "NVA68Infantry" >> "NVA_68heavyweaponsquad1";
// _count =  count (_groupConfig);
// for "_x" from 0 to (_count-1) do {
    // _item=((_groupConfig) select _x);
    // if (isClass _item) then {
		// _viper pushback getText (_item >> "vehicle");
    // };
// };
// _groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_E_NVA" >> "NVA68Infantry" >> "NVA_68Reconsquadone";
// _count =  count (_groupConfig);
// for "_x" from 0 to (_count-1) do {
    // _item=((_groupConfig) select _x);
    // if (isClass _item) then {
		// _viper pushback getText (_item >> "vehicle");
    // };
// };
// _groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_E_NVA" >> "NVA68Infantry" >> "NVA_68riflesquadone";
// _count =  count (_groupConfig);
// for "_x" from 0 to (_count-1) do {
    // _item=((_groupConfig) select _x);
    // if (isClass _item) then {
		// _viper pushback getText (_item >> "vehicle");
    // };
// };
_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_E_NVA" >> "DacCongInfantry" >> "NVA_DacCongcovert";
_count =  count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_viper pushback getText (_item >> "vehicle");
    };
};
_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_E_NVA" >> "DacCongInfantry" >> "NVA_DacCongquadone";
_count =  count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_viper pushback getText (_item >> "vehicle");
    };
};
_groupConfig = configfile >> "CfgGroups" >> "East" >> "UNSUNG_E_NVA" >> "DacCongInfantry" >> "NVA_DacCongquadtwo";
_count =  count (_groupConfig);
for "_x" from 0 to (_count-1) do {
    _item=((_groupConfig) select _x);
    if (isClass _item) then {
		_viper pushback getText (_item >> "vehicle");
    };
};

List_Viper = _viper;


_armouredVehicles = [];
_cfgVehicles = configFile >> "CfgVehicles";
_entries = count _cfgVehicles;
_realentries = _entries - 1;
for "_x" from 0 to (_realentries) do {
  _checked_veh = _cfgVehicles select _x;
  _classname = configName _checked_veh;
  if (isClass _checked_veh) then { // CHECK IF THE SELECTED ENTRY IS A CLASS
    _vehclass = getText (_checked_veh >> "vehicleClass");
    _scope = getNumber (_checked_veh >> "scope");
    _simulation_paracheck = getText (_checked_veh >> "simulation");
    _actual_vehclass = getText (_checked_veh >> "vehicleClass");
    if (_vehclass == _vehClass && _scope != 0 && _simulation_paracheck != "parachute" && _classname != "O_MBT_02_arty_F" && _actual_vehclass == "Armored") exitWith {
      _armouredVehicles pushback _classname;
    };
  };
};
List_Armour = _armouredVehicles;


_armedCars = [];
_cfgVehicles = configFile >> "CfgVehicles";
_entries = count _cfgVehicles;
_realentries = _entries - 1;
for "_x" from 0 to (_realentries) do {
  _checked_veh = _cfgVehicles select _x;
  _classname = configName _checked_veh;
  if (isClass _checked_veh) then {
    _vehclass = getText (_checked_veh >> "vehicleClass");
    _scope = getNumber (_checked_veh >> "scope");
    _simulation_paracheck = getText (_checked_veh >> "simulation");
    _actual_vehclass = getText (_checked_veh >> "vehicleClass");
    turretWeap = false;
    if (isClass (_checked_veh >> "Turrets")) then {
      _vechTurrets = _checked_veh >> "Turrets";
      for "_turretIter" from 0 to (count _vechTurrets - 1) do {
        _weapsOnTurret = _vechTurrets select _turretIter;
        if (!(getarray (_weapsOnTurret >> "weapons") isEqualTo [])) then {
          turretWeap = true;
        };
      };
    };
    if (_vehclass == _vehClass && _scope != 0 && _actual_vehclass == "Car" && turretWeap) exitWith {
      _armedCars pushback _classname;
    };
  };
};
List_ArmedCars = _armedCars;

