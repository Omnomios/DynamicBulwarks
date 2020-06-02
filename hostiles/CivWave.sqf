#include "..\shared\bulwark.hpp"

civClassArr = [];
private _spawnedCivs = [];
private _currentWave = attkWave;

CWS_GetRandomRoom = {
  private _civRoom = nil;
  while {isNil "_civRoom"} do {
    private _civBulding = selectRandom lootHouses;
    private _civRooms = _civBulding buildingPos -1;
    if (count _civRooms > 0) then {
      _civRoom = selectRandom _civRooms;
    };
  };
  _civRoom;
};

CWS_AddNextCivWaypoint = {
  params ["_spawnWave", "_civ"];
  
  private _civGroup = group _civ;
  if (_civGroup != grpNull) then {
    if (EAST countSide allUnits > 0 && _spawnWave == attkWave) then {
      //[format['New flee target for %1 in wave %2', _civ, _spawnWave], "SPECCIV"] call shared_fnc_log; 
      // During the wave civs should flee randomly
      private _civWaypointDestination = [bulwarkRoomPos, 0, BULWARK_RADIUS - 5,0,0,70,0] call BIS_fnc_findSafePos;
      //private _civWaypointDestination = call CWS_GetRandomRoom;
      private _waypoint = _civGroup addWaypoint [_civWaypointDestination, 0];
      _waypoint setWaypointType "Move";
      _waypoint setWaypointSpeed "FULL";
      _waypoint setWaypointCombatMode "BLUE";
      _waypoint setWaypointBehaviour "CARELESS";
      _waypoint setWaypointCompletionRadius 3;
      _waypoint setWaypointStatements [ "true", format ["[%1, this] call CWS_AddNextCivWaypoint", _spawnWave]];
    } else {
      // When all the enemies are dead or the wave has changed, civies should return to a building
      //[format['Finding despawn house for %1 in wave %2', _civ, _spawnWave], "SPECCIV"] call shared_fnc_log; 
      private _nBuilding = nearestBuilding _civ;
      private _civRooms = _nBuilding buildingPos -1;
      if (count _civRooms > 0) then {
        private _civRoom = selectRandom _civRooms;
        private _waypoint = _civGroup addWaypoint [_civRoom, 0];
        _waypoint setWaypointType "Move";
        _waypoint setWaypointSpeed "FULL";
        _waypoint setWaypointCombatMode "BLUE";
        _waypoint setWaypointBehaviour "CARELESS";
        _waypoint setWaypointCompletionRadius 2;
        _waypoint setWaypointStatements [ "true", "deleteVehicle this"];
      } else {
        // Couldn't find any room for the civ to go to, just remove it
        //[format['Force despawn for %1 in wave %2', _civ, _spawnWave], "SPECCIV"] call shared_fnc_log; 
        deleteVehicle _civ;
      };
    };
  };
};

//Create array of all Civ classes
private _civFaction = "CIV_F";
private _cfgVehiclesConfig = configFile >> "CfgVehicles";
private _cfgVehiclesConfigCount = count _cfgVehiclesConfig;
for [{_i = 0}, {_i < _cfgVehiclesConfigCount}, {_i = _i + 1}] do
{
  _config = _cfgVehiclesConfig select _i;
  if (isClass _config) then
  {
    _typeMan = getNumber (_config >> "isMan");
    if (_typeMan != 0) then
    {
      _faction = getText (_config >> "faction");
      if (_faction == _civFaction) then 
      {
        civClassArr set [count civClassArr, configName _config];
      };
    };
  };
};

for [{_i=0}, {_i<20}, {_i=_i+1}] do {
  //find random location for Civ to spawn
  private _civRoom = call CWS_GetRandomRoom;

  //spawn Civ
  _civClass = selectRandom civClassArr;
  _civgroup = createGroup [civilian, true];
  _civUnit = _civgroup createUnit [_civClass, _civRoom, [], 0.5, "FORM"];
  mainZeus addCuratorEditableObjects [[_civUnit], true];
  _civUnit addEventHandler ["Killed", killPoints_fnc_civKilled];

  _civUnit allowFleeing 0;
  _civUnit setBehaviour "CARELESS";

  [_currentWave, _civUnit] call CWS_AddNextCivWaypoint;
};

