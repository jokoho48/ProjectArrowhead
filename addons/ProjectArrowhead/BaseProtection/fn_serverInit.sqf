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

private _stateMachine = call CFUNC(createStatemachine);
[_stateMachine, "init", {
    [
        true,
        "DefendMainBase",
        [
            "Defend the Mother Fucking Main Base",
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
    GVAR(index) = (GVAR(index) + 1) mod ((count allGroups));
    private _grp = allGroups select GVAR(index);
    GVAR(Group) = _grp;
    private _nearBase = (getPos (leader _grp)) call MFUNC(nearBase);
    if !(_nearBase) exitWith {_exitState};
    if (!(GVAR(lastTaskName) call BIS_fnc_taskExists) || {GVAR(lastTaskName) call BIS_fnc_taskCompleted}) then {

        GVAR(lastTaskName) = "DefendBase" call MFUNC(taskName);
        [
            true,
            [GVAR(lastTaskName), "DefendMainBase"],
            [
                "Defend the Mother Fucking Main Base, Support the own forces",
                "Enemey Spotted At Base",
                ""
            ],
            objNull, "Created", 5, true, "defend", true
        ] call BIS_fnc_taskCreate;

        _exitState = "checkTask";
    };
    _exitState
}] call CFUNC(addStatemachineState);

[_stateMachine, "checkTask", {
    private _nearBase = (getPos (leader GVAR(Group))) call MFUNC(nearBase);
    if (_nearBase) exitWith {"checkTask"};
    [GVAR(lastTaskName), "SUCCEEDED", true] call BIS_fnc_taskSetState;
    "checkGroup"
}] call CFUNC(addStatemachineState);

[_stateMachine, "init", 1] call CFUNC(startStatemachine);
