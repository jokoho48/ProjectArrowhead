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

if (_type isEqualType 0) then {
    _type = ["inf", "veh", "air", "sniper", "static", "statichigh", "staticmortar"] select _type;
} else {
    _type = toLower _type;
};

switch (_side) do {
    case (west): {
        switch (_type) do {
            case ("veh"): {
                selectRandom GVAR(vehiclePoolFriendly);
            };
            case ("air"): {
                selectRandom GVAR(airPoolFriendly);
            };
            default {
                selectRandom GVAR(unitPoolFriendly);
            };
        };
    };
    case (independent): {
        switch (_type) do {
            case ("veh"): {
                selectRandom GVAR(vehiclePoolRebels);
            };
            default {
                selectRandom GVAR(unitPoolRebels);
            };
        };
    };
    case (Civilian): {
        switch (_type) do {
            case ("veh"): {
                selectRandom GVAR(vehiclePoolCiv);
            };
            default {
                selectRandom GVAR(unitPoolCiv);
            };
        };
    };
    default {
        switch (_type) do {
            case ("veh"): {
                selectRandom GVAR(vehiclePoolEnemy);
            };
            case ("air"): {
                selectRandom GVAR(airPoolEnemy);
            };
            case ("sniper"): {
                selectRandom GVAR(sniperPoolEnemy);
            };
            case ("static"): {
                selectRandom GVAR(staticPoolEnemy);
            };
            case ("statichigh"): {
                selectRandom GVAR(staticHighPoolEnemy);
            };
            case ("staticmortar"): {
                selectRandom GVAR(staticMortarEnemy);
            };
            default {
                selectRandom GVAR(unitPoolEnemy);
            };
        };
    };
};
