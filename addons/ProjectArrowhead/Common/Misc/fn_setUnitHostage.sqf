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
params ["_unit", "_state"];

["ACE_handcuffUnit", _unit, [_unit, _state]] call CFUNC(targetEvent);
