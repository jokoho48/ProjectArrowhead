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

private _playerCount = count allPlayers;
ceil ((_playerCount max 1) * abs(log(((_playerCount max 1)/6)/256)));
