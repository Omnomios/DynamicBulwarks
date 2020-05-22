# Bug Fixes
* FIXED Revive issues (maybe add in http://www.armaholic.com/page.php?id=24088)?
* Long start time for some waves
* Vehicles stick around based on timer, not wave
* Player corpses stick around based on timer
* Guns sometimes get removed when accessing gear
* FIXED Are ammo drops happening in the right place?
* missionLoop is a tight while loop
* FIXED Also it seems the first aid kits dropped by nato allow healing but the others dont when using PIR
* FIXED Auto-revive with medikits broken
* FIXED Mag Repack might conflict with existing mods, we should check
* The number of units at higher end waves is crunching the game.  We need to spread it out.
* Drone waves spawn too many drones, its frustrating players.  Drones would be better as additions to existing waves as a distraction.

# New Features
* DONE: Finish the lobby system
* DONE Scaling vehicle waves (maybe with a vehicle costing table and wave budget), https://community.bistudio.com/wiki/CfgVehicles_Config_Reference#cost
* DONE UI Support for multiple-selection options
* AI target buildings with grenades/explosives
  * Needs investigation - destroy waypoints
  * We already have activation radius for suicide bombers - extend to explosives specialists to opportunistically plant explosives next to your constructions
  * Extend to bulwark to make it destructible
  * Audio or visual cue that bulwark is under threat
  * Explosives on timer, use new disarm functionality to mitigate
* Faction-based enemies
* Tweak spawn list to remove backpacks and other useless spawn items
* Spawn groups instead of individuals?
* Spawns between waves?
* Play at different times of the year?
* Slower transition to night time using time acceleration?
* FIXED Team-wide bulwark points
* "Shareable" bulwark points (player can choose to give another player some of their points)
* Progressived spawning (cap on how many units can spawn at once, trickle them in over time)


# ISSUES
* FIXED HandleDamage registered each time the player respawns
* FIXED initPlayerLocal would not correctly start the player if they JIP and the game is started
* FIXED HandleDamage registered both in startPlayer and onPlayerRespawn.  onPlayerRespawn does not seem to be called until the player actually respawns from going down, so we might need to execute the code in there from startPlayer.
* FIXED Refactor player initialization to spawn a script which recognizes the two modes: lobby and in game, and configures the player appropriately based on which mode the game is currently in.
  


