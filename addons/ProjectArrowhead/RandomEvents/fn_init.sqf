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

DFUNC(earthQuake) = {
    [QGVAR(earthQuake), (ceil (random 4))] call CFUNC(globalEvent);
};
[QGVAR(earthQuake), {
    if !(hasInterface) exitWith {};
    (_this select 0) spawn BIS_fnc_earthquake;
}] call CFUNC(addEventhandler);

call FUNC(airAttack);
call FUNC(rebelAttack);
