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
params [["_pos1", [],[[]]], ["_pos2", [],[[]]]];

private _dX = ((_pos2 select 0) - (_pos1 select 0));
private _dY = ((_pos2 select 1) - (_pos1 select 1));
[((cos(60) * _dX - sin(60) * _dY) + (_pos1 select 0)), (sin(60) * _dX + cos(60) * _dY) + (_pos1 select 1)]
