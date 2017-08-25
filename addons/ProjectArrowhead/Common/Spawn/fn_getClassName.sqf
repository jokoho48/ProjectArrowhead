#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Get a random ClassName from the Base Data

    Parameter(s):
    0: Side <Side>
    1: Type <Number>

    Returns:
    0: Return <Type>
*/
params [["_side", east], ["_type", 0]];

private "_vehType";
if (_type isEqualType []) then {
    _vehType = _type select 1;
    _type = _type select 0;
};

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
                if (isNil "_vehType") then {
                    _vehType = round (random 3);
                };
                if (_vehType isEqualType 0) then {
                    _vehType = ["mrap", "light", "aa", "heavy"] select _vehType;
                } else {
                    _vehType = toLower _vehType;
                };
                switch (_vehType) do {
                    case ("heavy"): {
                        selectRandom GVAR(vehicleHeavyPoolEnemy);
                    };
                    case ("light"): {
                        selectRandom GVAR(vehicleLightPoolEnemy);
                    };
                    case ("aa"): {
                        selectRandom GVAR(vehicleAAPoolEnemy);
                    };
                    default {
                        selectRandom GVAR(vehicleMRAPPoolEnemy);
                    };
                };
            };
            case ("air"): {
                if (isNil "_vehType") then {
                    _vehType = round (random 1);
                };
                if (_vehType isEqualType 0) then {
                    _vehType = ["slow", "attack", "fast"] select _vehType;
                } else {
                    _vehType = toLower _vehType;
                };
                switch (_vehType) do {
                    case ("attack"): {
                        selectRandom GVAR(airAttackPoolEnemy);
                    };
                    case ("fast"): {
                        selectRandom GVAR(airFastPoolEnemy);
                    };
                    default {
                        selectRandom GVAR(airSlowPoolEnemy);
                    };
                };
            };
            case ("sniper"): {
                selectRandom GVAR(sniperPoolEnemy);
            };
            case ("static"): {
                if (isNil "_vehType") then {
                    _vehType = round (random 2);
                };
                if (_vehType isEqualType 0) then {
                    _vehType = ["low", "high", "mortar"] select _vehType;
                } else {
                    _vehType = toLower _vehType;
                };
                switch (_vehType) do {
                    case ("low"): {
                        selectRandom GVAR(staticPoolEnemy);
                    };
                    case ("mortar"): {
                        selectRandom GVAR(staticMortarEnemy);
                    };
                    default {
                        selectRandom GVAR(staticHighPoolEnemy);
                    };
                };
            };

            default {
                selectRandom GVAR(unitPoolEnemy);
            };
        };
    };
};
