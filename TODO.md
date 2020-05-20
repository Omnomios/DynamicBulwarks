# Bug Fixes
* Revive issues (maybe add in http://www.armaholic.com/page.php?id=24088)?
* Long start time for some waves
* Vehicles stick around based on timer, not wave
* Player corpses stick around based on timer
* Guns sometimes get removed when accessing gear
* Are ammo drops happening in the right place?
  * No, the target waypoint is always the same location, random drift of the parachute is what causes it to actually end up in random places.
* missionLoop is a tight while loop
* FIXED Also it seems the first aid kits dropped by nato allow healing but the others dont when using PIR
* FIXED Auto-revive with medikits broken


# New Features
* DONE: Finish the lobby system
* DONE Scaling vehicle waves (maybe with a vehicle costing table and wave budget), https://community.bistudio.com/wiki/CfgVehicles_Config_Reference#cost
* AI target buildings with grenades/explosives
  * Needs investigation - destroy waypoints
* Faction-based enemies
* Tweak spawn list to remove backpacks and other useless spawn items
* Spawn groups instead of individuals?
* Spawns between waves?
* Play at different times of the year?
* Slower transition to night time using time acceleration?


# ISSUES
* FIXED HandleDamage registered each time the player respawns
* FIXED initPlayerLocal would not correctly start the player if they JIP and the game is started
* FIXED HandleDamage registered both in startPlayer and onPlayerRespawn.  onPlayerRespawn does not seem to be called until the player actually respawns from going down, so we might need to execute the code in there from startPlayer.
* FIXED Refactor player initialization to spawn a script which recognizes the two modes: lobby and in game, and configures the player appropriately based on which mode the game is currently in.
  


