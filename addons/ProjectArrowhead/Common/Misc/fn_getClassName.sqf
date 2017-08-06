#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Description

    Parameter(s):
    0: Side <Side>
    1: Type <Number>

    Returns:
    0: Return <Type>
*/
params [["_side", east], ["_type", 0]];
switch (_side) do {
    case (west): {
        switch (_type) do {
            case (1): {
                selectRandom GVAR(vehiclePoolFriendly);
            };
            case (2): {
                selectRandom GVAR(airPoolFriendly);
            };
            default {
                selectRandom GVAR(unitPoolFriendly);
            };
        };
    };
    case (independent): {
        switch (_type) do {
            case (1): {
                selectRandom GVAR(vehiclePoolRebels);
            };
            default {
                selectRandom GVAR(unitPoolRebels);
            };
        };
    };
    case (Civilian): {
        switch (_type) do {
            case (1): {
                selectRandom GVAR(vehiclePoolCiv);
            };
            default {
                selectRandom GVAR(unitPoolCiv);
            };
        };
    };
    default {
        switch (_type) do {
            case (1): {
                selectRandom GVAR(vehiclePoolEnemy);
            };
            case (2): {
                selectRandom GVAR(airPoolEnemy);
            };
            case (3): {
                selectRandom GVAR(sniperPoolEnemy);
            };
            default {
                selectRandom GVAR(unitPoolEnemy);
            };
        };
    };
};
