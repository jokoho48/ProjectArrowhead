#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:
    Description

    Parameter(s):
    0: Argument <Type>

    Returns:
    0: Return <Type>
*/
params ["_unit", "_state"];

["ACE_handcuffUnit", [_unit, _state]] call CFUNC(globalEvent);
