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

GVAR(ObjCompArray) = [];

[QMGVAR(mainAOGenerated), {
    [{
        call FUNC(spawn);
    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventhandler);
