#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Returns a Random Pos on the Map Border

    Parameter(s):
    None

    Returns:
    Position <Position>
*/
selectRandom [
    [0, 0, 0],
    [worldSize, worldSize, 0],
    [worldSize, 0, 0],
    [0, worldSize, 0],
    [worldSize/2, 0, 0],
    [0, worldSize/2, 0],
    [worldSize, worldSize/2, 0],
    [worldSize/2, worldSize, 0],
    [worldSize/(random 2), 0, 0],
    [0, worldSize/(random 2), 0],
    [worldSize, worldSize/(random 2), 0],
    [worldSize/(random 2), worldSize, 0]
];
