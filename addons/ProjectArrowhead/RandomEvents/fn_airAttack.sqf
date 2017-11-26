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

DFUNC(airAttackTrigger) = {
    QGVAR(airAttackSpawn) call CFUNC(serverEvent); // TODO: Make HC Compatible
};

[QGVAR(airAttackSpawn), {
    RUNTIMESTART;
    private _target = call MFUNC(getPlayerTarget);

    if !(alive _target) exitWith {};

    private _uPos = getPos _target;

    private _pos = call MFUNC(getWorldEdgePos);

    private _grp = group (([_pos, 2, 1, east, true] call MFUNC(spawnGroup)) select 0);
    private _veh = (vehicle (leader _grp));
    #ifdef ISDEV
    [_pos, "o_unknown", "ColorCIV", 0, "Air Attack"] call MFUNC(createDebugMarker);
    #endif

    private _wp1 = _grp addWaypoint [_uPos, 0];
    _wp1 setWaypointType "SAD"; // Seek And Destroy
    _wp1 setWaypointBehaviour "COMBAT";
    _wp1 setWaypointCombatMode "RED";
    _wp1 setWaypointCompletionRadius 200;
    _wp1 setWaypointSpeed "SLOW";
    _wp1 setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 2];"];

    private _wp2 = _grp addWaypoint [_uPos, 0];
    _wp2 setWaypointType "LOITER";
    _wp2 setWaypointBehaviour "COMBAT";
    _wp2 setWaypointCombatMode "RED";
    _wp2 setWaypointCompletionRadius 200;
    _wp2 setWaypointLoiterRadius 200;
    _wp2 setWaypointSpeed "SLOW";
    _wp2 setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];"];

    private _wp3 = _grp addWaypoint [_pos, 0];
    _wp3 setWaypointType "MOVE";
    _wp3 setWaypointBehaviour "COMBAT";
    _wp3 setWaypointCombatMode "RED";
    _wp3 setWaypointCompletionRadius 0;
    _wp3 setWaypointSpeed "FAST";
    _wp3 setWaypointStatements ["true", 'GARBAGE(group this)'];

    [QGVAR(airAttackTask), [_uPos, _grp, _target]] call CFUNC(serverEvent);
    RUNTIME("Spawn Air Attack");
}] call CFUNC(addEventhandler);

[QGVAR(airAttackTask), {

    (_this select 0) params ["_pos", "_grp", "_target"];
    private _veh = vehicle (leader _grp);
    [{
        params ["_pos", "_grp", "_target", "_veh"];
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

        [{
            (_this select 0) params ["_veh", "_grp", "_target", "_taskID"];
            private _unitCount = {_x call MFUNC(isAwake)} count (units _grp);
            if (_unitCount == 0 || !alive _veh) exitWith {
                [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
                (_this select 1) call CFUNC(removePerFrameHandler);
                GARBAGE(_grp);
            };
            private _leader = leader _grp;
            private _distance = _target distance2D _leader;
            private _isPlayerEnemy = isPlayer (_leader findNearestEnemy _leader);
            if ((_distance > 2000) && !_isPlayerEnemy) exitWith {
                [_taskID, "CANCELED"] call BIS_fnc_taskSetState;
                _veh forceSpeed (_veh getSpeed "FAST");
                _grp setCurrentWaypoint [_grp, 3];
                (_this select 1) call CFUNC(removePerFrameHandler);
            };
        }, 5, [_veh, _grp, _target, _taskID]] call CFUNC(addPerFrameHandler);

        [{
            params ["_grp"];
            if !(alive vehicle leader _grp) exitWith {
                GARBAGE(_grp);
            };
            private _veh = (vehicle (leader _grp));
            _veh forceSpeed (_veh getSpeed "FAST");
            _grp setCurrentWaypoint [_grp, 3];
        }, 1000, _grp] call CFUNC(wait);
    }, {
        params ["_pos", "_grp", "_target","_veh"];
        (_pos distance _veh) <= 1500 || _target distance _pos >= 3000 || !(_grp call MFUNC(aliveGroup))
    }, [_pos, _grp, _target, _veh]] call CFUNC(waitUntil);
}] call CFUNC(addEventhandler);
