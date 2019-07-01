/**
*  fn_paraTroop
*
*  Calls VTOL to drop a group of paratroopers on the specified location
*
*  Domain: Server
**/
params ["_player", "_targetPos", "_unitCount", "_aircraft", "_classList"];

if (count _targetPos == 0) then {
  [_player, "paraDrop"] remoteExec ["BIS_fnc_addCommMenuItem", _player]; //refund the support if looking at sky when activated
}else{
  _angle = round random 180;
  _height = 300;
  _offsX = 0;
  _offsY = 1000;
  _pointX = _offsX*(cos _angle) - _offsY*(sin _angle);
  _pointY = _offsX*(sin _angle) + _offsY*(cos _angle);

  _dropStart  = _targetPos vectorAdd [_pointX, _pointY, _height];
  _dropTarget = [(_targetPos select 0), (_targetPos select 1), 200];
  _dropEnd    = _targetPos vectorAdd [-_pointX*2, -_pointY*2, _height];;

  _targetSmoker = "SmokeShellOrange" createVehicle (_targetPos vectorAdd [0,0,0.3]);

  _agSpawn = [_dropStart, 0, _aircraft, WEST] call bis_fnc_spawnvehicle;
  _agVehicle = _agSpawn select 0;	//the aircraft
  _agCrew = _agSpawn select 1;	//the units that make up the crew
  _ag = _agSpawn select 2;	//the group
  {_x allowFleeing 0} forEach units _ag;

  _agVehicle flyInHeight 100;
  _agVehicle setpos [getposATL _agVehicle select 0, getposATL _agVehicle select 1, _height];

  _relDir = [_dropStart, _targetPos] call BIS_fnc_dirTo;
  _agVehicle setdir _relDir;

  paraTroopLatch = false;

  _waypoint0 = _ag addwaypoint[_dropTarget, 0];
  _waypoint0 setwaypointtype "Move";
  _waypoint0 setWaypointCompletionRadius 5;
  _waypoint0 setWaypointStatements ["true", "paraTroopLatch = true;"];

  _waypoint1 = _ag addwaypoint[_dropEnd, 0];
  _waypoint1 setwaypointtype "Move";

  [_ag, 1] setWaypointSpeed "FULL";
  [_ag, 1] setWaypointCombatMode "RED";
  [_ag, 1] setWaypointBehaviour "CARELESS";

  _agVehicle animateDoor ['Door_1_source', 1];
  waitUntil {paraTroopLatch};

  sleep 0.5;

  coreGroup = group _player;
  [group _player, _player] remoteExec ["selectLeader", groupOwner group _player];

  for ("_i") from 1 to PARATROOP_COUNT do {
      _location = getPos _agVehicle;
      _unitClass = selectRandom _classList;
      _unit = objNull;
      _unit = coreGroup createUnit [_unitClass, _location vectorAdd [0,0,-2], [], 0.5, "CAN_COLLIDE"];
      mainZeus addCuratorEditableObjects [[_unit], true];
      sleep 0.3;
      waitUntil {!isNull _unit};
      _unit addBackpack "B_Parachute";
      _unit setSkill ["aimingAccuracy", 0.8];
      _unit setSkill ["aimingSpeed", 0.7];
      _unit setSkill ["aimingShake", 0.8];
      _unit setSkill ["spotTime", 1];
      _unit doMove _targetPos;


      _unit addEventHandler ["Killed", {
      _self = _this select 0;
      removeVest _self;
      removeBackpack _self;
      removeAllWeapons _self:
      removeAllAssignedItems _self;
      }];
  };

  sleep 20;
  deleteVehicle _agVehicle;
  {deleteVehicle _x} foreach _agCrew;
};
