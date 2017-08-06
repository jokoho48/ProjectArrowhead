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
params [["_value", 1]];
private _playerCount = count allPlayers;
ceil ((_playerCount max _value) * abs(log(((_playerCount max _value)/6)/256)));
