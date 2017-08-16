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

GVAR(spawnPos) = [
    [0, 0, 0],
    [worldSize, worldSize, 0],
    [worldSize, 0, 0],
    [0, worldSize, 0],
    [worldSize/2, 0, 0],
    [0, worldSize/2, 0],
    [worldSize, worldSize/2, 0],
    [worldSize/2, worldSize, 0],
    [worldSize/(random 2), 0, 0],
    [0, worldSize/(random 2), 0],
    [worldSize, worldSize/(random 2), 0],
    [worldSize/(random 2), worldSize, 0]
];

DFUNC(airAttack) = {
    QGVAR(airAttackSpawn) call CFUNC(serverEvent); // TODO: Make HC Compatible
};

[QGVAR(airAttackSpawn), {

    private _target = call MFUNC(getPlayerTarget);

    if !(alive _target) exitWith {};

    private _uPos = getPos _target;

    private _pos = selectRandom [[0, 0, 0], [worldSize, worldSize, 0], [worldSize, 0, 0], [0, worldSize, 0], [worldSize/2, 0, 0], [0, worldSize/2, 0], [worldSize, worldSize/2, 0], [worldSize/2, worldSize, 0], [worldSize/(random 2), 0, 0], [0, worldSize/(random 2), 0], [worldSize, worldSize/(random 2), 0], [worldSize/(random 2), worldSize, 0]];

    private _grp = group ([_pos, 2, 1] call MFUNC(spawnGroup));

    #ifdef ISDEV
    [_pos, "o_unknown", "ColorCIV", 0, "Rebel"] call MFUNC(createMarker);
    #endif

    private _wp1 = _grp addWaypoint [_uPos, 0];
    _wp1 setWaypointType "SAD"; // Seek And Destroy
    [_grp, 1] setWaypointBehaviour "COMBAT";
    [_grp, 1] setWaypointCombatMode "RED";
    [_grp, 1] setWaypointCompletionRadius 75;
    [_grp, 1] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 2]"];

    private _wp2 = _grp addWaypoint [_uPos, 0];
    _wp2 setWaypointType "LOITER";
    [_grp, 2] setWaypointBehaviour "COMBAT";
    [_grp, 2] setWaypointCombatMode "RED";
    [_grp, 2] setWaypointCompletionRadius 75;
    [_grp, 2] setWaypointLoiterRadius 75;
    [_grp, 2] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1]"];

    private _wp3 = _grp addWaypoint [_pos, 0];
    _wp3 setWaypointType "MOVE";
    [_grp, 3] setWaypointBehaviour "COMBAT";
    [_grp, 3] setWaypointCombatMode "RED";
    [_grp, 3] setWaypointCompletionRadius 75;
    [_grp, 3] setWaypointLoiterRadius 75;
    [_grp, 3] setWaypointStatements ["true", 'GARBAGE(group this))'];

    [QGVAR(airAttackTask), [_uPos, _grp, _target]] call CFUNC(serverEvent);
}] call CFUNC(addEventhandler);

[QGVAR(rebelAttackTask), {
    [{
        params ["_pos", "_grp", "_target"];
        private _taskID = "AirAttack" call MFUNC(taskName);
        [
            west,
            [_taskID],
            [
                "Beware of enemy aircraft!",
                "Enemy aircontact sighted!",
                ""
            ],
            _pos vectorAdd [random 50, random 50, 0], false,2,true,"destroy",false
        ] call BIS_fnc_taskCreate;
        private _veh = vehicle (leader _grp);
        [{
            (_this select 0) params ["_pos", "_veh", "_grp", "_target", "_taskID"];

            private _unitCount = {_x call MFUNC(isAwake)} count (units _grp);
            if (_unitCount == 0 || !alive _veh) exitWith {
                [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
                (_this select 1) call CFUNC(removePerFrameHandler);
                GARBAGE(_grp);
            };
            private _leader = leader _grp;
            private _tarPos = getPos _target;
            private _distance = _target distance2D _leader;
            private _isPlayerEnemy = isPlayer (_leader findNearestEnemy _leader);
            if ((_distance > 2000) && !_isPlayerEnemy) exitWith {
                [_taskID, "CANCELED"] call BIS_fnc_taskSetState;
                _grp setCurrentWaypoint [_grp, 3];
                (_this select 1) call CFUNC(removePerFrameHandler);
            };
        }, 5, [_pos, _veh, _grp, _target, _taskID]] call CFUNC(addPerFrameHandler);

        [{
            (_this select 0) params ["_grp"];
            if !(alive vehicle leader _grp) exitWith {
                    GARBAGE(_grp);
            };
            _grp setCurrentWaypoint [_grp, 3];
        }, 1000, _grp] call CFUNC(wait);

    }, 10, _this select 0] call CFUNC(wait);
}] call CFUNC(addEventhandler);
