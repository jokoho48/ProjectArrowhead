#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Init for Common Module

    Parameter(s):
    None

    Returns:
    None
*/
params ["_name"];
_name = _name + str GVAR(taskID);
GVAR(taskID) = GVAR(taskID) + 1;
_name
