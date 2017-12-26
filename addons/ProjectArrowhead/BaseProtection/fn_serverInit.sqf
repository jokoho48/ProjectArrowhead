#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Server Init for BaseProtection

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(enemyAtBase) = false;
publicVariable QGVAR(enemyAtBase);

["missionStarted", {
    private _stateMachine = call CFUNC(createStatemachine);
    [_stateMachine, "init", {
        [
            true,
            "DefendMainBase",
            [
                "",
                "Defend Main Base",
                ""
            ],
            MGVAR(baseMarker), "Created", 5, true, "defend", true
        ] call BIS_fnc_taskCreate;
        GVAR(lastTaskName) = "";
        GVAR(index) = -1;
        GVAR(Group) = grpNull;
        "checkGroup"
    }] call CFUNC(addStatemachineState);

    [_stateMachine, "checkGroup", {
        private _exitState = "checkGroup";
        GVAR(index) = ((GVAR(index) + 1) mod (count allGroups));
        private _grp = allGroups select GVAR(index);
        if (side _grp in [west, civilian, sideUnknown, sideLogic]) exitWith {_exitState};
        private _nearBase = (getPos (leader _grp)) call MFUNC(nearBase);
        if !(_nearBase) exitWith {_exitState};
        if (!(GVAR(lastTaskName) call BIS_fnc_taskExists) || {GVAR(lastTaskName) call BIS_fnc_taskCompleted}) then {
            GVAR(Group) = _grp;

            GVAR(lastTaskName) = "DefendBase" call MFUNC(taskName);
            [
                true,
                [GVAR(lastTaskName), "DefendMainBase"],
                [
                    "Enemy forces have been spotted near the base, prepare for assault!",
                    "Defend Main Base",
                    ""
                ],
                getPos (leader GVAR(Group)) vectorAdd [(random 100) - 50, (random 100) - 50, 0], "Created", 5, true, "defend", true
            ] call BIS_fnc_taskCreate;
            GVAR(enemyAtBase) = true;
            publicVariable QGVAR(enemyAtBase);
            _exitState = "checkTask";
        };
        _exitState
    }] call CFUNC(addStatemachineState);

    [_stateMachine, "checkTask", {
        private _nearBase = (getPos (leader GVAR(Group))) call MFUNC(nearBase);
        if (_nearBase) exitWith {"checkTask"};
        GVAR(enemyAtBase) = false;
        publicVariable QGVAR(enemyAtBase);
        GVAR(Group) = grpNull;
        [GVAR(lastTaskName), "SUCCEEDED", true] call BIS_fnc_taskSetState;
        [{
            GVAR(lastTaskName) call BIS_fnc_deleteTask;
        }, 10] call CFUNC(wait);
        "checkGroup"
    }] call CFUNC(addStatemachineState);
    [_stateMachine, "init", 0.5] call CFUNC(startStatemachine);
}] call CFUNC(addEventhandler);
