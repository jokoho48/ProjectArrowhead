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

if ((GVAR(missionAmount) > 0) && {GVAR(missionAmount) == GVAR(missionCounter)}) then {
    "WON" call BIS_fnc_EndMissionServer;
} else {
    private _mission = selectRandom GVAR(mainMissions);
    _mission params ["_name", "_function", "_origin", "_cfg"];

    private _code = missionNamespace getVariable _function;
    if (isNil "_code") then {
        _code = compile _function;
    };

    [_name, _origin, _cfg] call _code;

    if !(GVAR(isFirstCallDone)) then {
        GVAR(isFirstCallDone) = true;
        [{
            QMGVAR(mainAOGenerated) call CFUNC(globalEvent);
        }, 1] call CFUNC(wait);
    };
    GVAR(missionCounter) = GVAR(missionCounter) + 1;
};
