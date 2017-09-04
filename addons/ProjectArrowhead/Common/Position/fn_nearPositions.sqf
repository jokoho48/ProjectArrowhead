#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Description

    Parameter(s):
    0: Position <Position>
    1: Posible Positions <Array<Position>>

    Returns:
    is Near one of the Positions
*/
params ["_pos", "_dist", "_posArray"];

{
    if (_x distance2D _pos < _dist ) exitWith {
        true breakOut SCRIPTSCOPENAME;
    };
    nil
} count _posArray;
false
