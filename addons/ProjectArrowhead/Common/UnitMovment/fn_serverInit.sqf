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
private _fnc_exitPatrol = {
    private _grp = (group this);
    if (_grp getVariable [QGVAR(ExitPatrol), false]) then {
        {
            deleteWaypoint _x;
            nil
        } count waypoints _grp;
        nil;
    };
};

DFUNC(exitPatrol) = _fnc_exitPatrol call CFUNC(codeToString);
