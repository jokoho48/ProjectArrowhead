enableSaving [false, false];
enableEnvironment [false, true];
enableSentences false;
{_x setmarkeralpha 0} forEach (allmapmarkers select {(getmarkertype _x) find "respawn" > -1});
call CLib_fnc_loadModules;
if !(isServer) then {
	null = [] execVM "diary.sqf";					//Diary
};

if ((!isServer) && (player != player)) then {waitUntil {player == player};};

titleText ["SNOW STORM SCRIPT DEMO", "BLACK FADED", 0.2];

setViewDistance 2000;

[] execVM "briefing.sqf";

// Snow Storm

// running script without breath vapors and no wind bursts, fog using values you set in editor
//null = [180,180,false,30,false,false,false,false] execvm "AL_snowstorm\al_snow.sqf";

// running script with breath vapors and wind bursts on server side, fog managed by script
null = [80,240,false,40,true,true,false,true] execvm "AL_snowstorm\al_snow.sqf";

// with breath vapors and wind bursts on client side, fog managed by script
//null = [80,240,false,40,true,false,true,true] execvm "AL_snowstorm\al_snow.sqf";
