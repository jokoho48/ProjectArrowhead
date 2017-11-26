#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Find a Position in a Building around a Center Pos

    Parameter(s):
    0: Position <Position>

    Returns:
    Position is On Map <Bool>
*/
params ["_pos"];
_pos inArea [GVAR(centerPos), GVAR(worldSize), GVAR(worldSize), 0, true];
