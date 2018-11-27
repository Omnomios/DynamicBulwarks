/**
*  fn_endWave
*
*  Wave ended (mission complete)
*
*  Domain: Server
**/

bulwarkBox setVariable ["buildPhase", true, true];

["TaskSucceeded",["Complete","Wave " + str attkWave + " complete!"]] remoteExec ["BIS_fnc_showNotification", 0];
[0] remoteExec ["setPlayerRespawnTime", 0];

{
	// Revive players that died at the end of the round.
	if ((lifeState _x == "DEAD") || (lifeState _x == "INCAPACITATED")) then {
		forceRespawn _x;
	};
} foreach allPlayers;

// Try to force the spectator mode off when players are revived.
["Terminate"] remoteExec ["BIS_fnc_EGSpectator", 0];

//Kill all mind controlled AI
{
	 _x setDamage 1;
}foreach MIND_CONTROLLED_AI;
MIND_CONTROLLED_AI = [];
publicVariable "MIND_CONTROLLED_AI";

sleep _downTime;
