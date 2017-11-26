#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Description

    Parameter(s):
    0: Argument <Type>

    Returns:
    0: Return <Type>
*/
GVAR(rebelAttackSize) = 5;

DFUNC(rebelAttackTrigger) = {
    QGVAR(rebelAttackSpawn) call CFUNC(serverEvent); // TODO: Make HC Compatible
};

[QGVAR(rebelAttackSpawn), {
    RUNTIMESTART;
    private _target = call MFUNC(getPlayerTarget);

    if !(alive _target) exitWith {};

        private _uPos = getPos _target;
    private _pos = [_uPos, 1000, 1200] call MFUNC(selectRandomPos);

    while {(([_pos,900] call MFUNC(getClosePlayers)) isEqualTo [])&& (surfaceIsWater _pos)} do {
        _pos = [_uPos, 1000, 1200] call MFUNC(selectRandomPos);
    };

    private _grp = [_pos, 0, random [GVAR(rebelAttackSize) - 2, GVAR(rebelAttackSize), GVAR(rebelAttackSize) + 4], independent] call MFUNC(spawnGroup);
    _grp setVariable ["BSO_RBU_allowed", false, true];
    #ifdef ISDEV
    [_pos, "o_unknown", "ColorCIV", 0, "Rebel"] call MFUNC(createDebugMarker);
    #endif

    private _wp = _grp addWaypoint [getPos _target, 0];
    _wp setWaypointType "SAD";
    _wp setWaypointSpeed "FULL";
    _wp setWaypointCombatMode "RED";

    [QGVAR(rebelAttackTask), [_uPos, _grp, _target]] call CFUNC(serverEvent);
    RUNTIME("Spawn Air Attack");
}] call CFUNC(addEventhandler);

[QGVAR(rebelAttackTask), {
    [{
        params ["_pos", "_grp", "_target"];
        private _taskID = "RebelAttack" call MFUNC(taskName);
        [
            west,
            [_taskID],
            [
                "Rebel activity has been reported in the area, watch your backs boys.",
                "Rebel activity reported!",
                ""
            ],
            _pos vectorAdd [random 50, random 50, 0], false,2,true,"C",false
        ] call BIS_fnc_taskCreate;

        [{
            (_this select 0) params ["_grp", "_target", "_taskID"];

            private _leader = leader _grp;
            private _distance = _target distance2D _leader;
            private _isPlayerEnemy = isPlayer (_leader findNearestEnemy _leader);
            if ((_distance > 2000) && !_isPlayerEnemy) exitWith {
                [_taskID, "CANCELED", true] call BIS_fnc_taskSetState;
                GARBAGE(_grp);
                (_this select 1) call CFUNC(removePerFrameHandler);
            };
            private _unitCount = {_x call MFUNC(isAwake)} count (units _grp);
            if (_unitCount == 0) exitWith {
                [_taskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;
                (_this select 1) call CFUNC(removePerFrameHandler);
                GARBAGE(_grp);
            };
        }, 5, [_grp, _target, _taskID]] call CFUNC(addPerFrameHandler);
    }, 10, _this select 0] call CFUNC(wait);
}] call CFUNC(addEventhandler);
