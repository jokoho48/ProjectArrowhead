#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Find a Thired Triangle Position of 2 Positions

    Parameter(s):
    0: Position 1 <Position>
    1: Position 2 <Position>

    Returns:
    Position <Position>
*/
params [["_pos1", [],[[]]], ["_pos2", [],[[]]]];

private _dX = ((_pos2 select 0) - (_pos1 select 0));
private _dY = ((_pos2 select 1) - (_pos1 select 1));
[((cos(60) * _dX - sin(60) * _dY) + (_pos1 select 0)), (sin(60) * _dX + cos(60) * _dY) + (_pos1 select 1)]
