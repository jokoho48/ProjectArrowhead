#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Init for Common Module

    Parameter(s):
    None

    Returns:
    None
*/


GVAR(baseMarker) = "Base";
["DisplayHint", {
    (_this select 0) params ["_headerText", "_mainText"];
    [format ["<t size='1' color='#ff0000'>%1</t><br/><t size='0.6'>%2</t>", _headerText, _mainText]] spawn bis_fnc_dynamicText;
}] call CFUNC(addEventhandler);


DFUNC(onPinged) = {
    params ["_curator", "_unit"];

    private _pingCount = _unit getVariable QGVAR(curatorPingCount);
    private _lastPingTime = _unit getVariable QGVAR(lastPingTime);

    if (isnil "_pingCount") then {
        _unit setVariable [QGVAR(curatorPingCount), 1, false];
        _unit setVariable [QGVAR(lastPingTime), time, false];
    } else {
        _pingCount = _pingCount + 1;

        if (_lastPingTime <= time - 20) then {
            _unit setVariable ["derp_lastPingTime", time, false];
            _unit setVariable [QGVAR(lastPingTime), 1, false];
        } else {
            if (_pingCount == 4) then {
                ["DisplayHint", _unit, ["YOU HAVE ANGERD ZEUS", "wait 20s before pressing the zeus ping button again, or die."]] call CFUNC(targetEvent);
            };
            if (_pingCount >= 5) then {
                _unit setDamage 1;
                _unit setVariable [QGVAR(curatorPingCount), nil, false];
                _unit setVariable [QGVAR(lastPingTime), nil, false];
            } else {
                _unit setVariable [QGVAR(lastPingTime), time, false];
                _unit setVariable [QGVAR(curatorPingCount), _pingCount, false];
            };
        };
    };
};

["entityCreated", {
    (_this select 0) params ["_obj"];
    if (_obj isKindOf "ModuleCurator_F") then {
        _obj addEventHandler ["CuratorPinged", { _this call FUNC(onPinged); }];
    };
    if !(_obj getVariable [QEGVAR(Caching,onCache), false]) then {
        _obj enableDynamicSimulation true;
        (group _obj) enableDynamicSimulation true;
    };
}] call CFUNC(addEventhandler);

if (isServer) then {
    ["entityCreated", {
        (_this select 0) params ["_obj"];
        {
            _x addCuratorEditableObjects [[_obj], true];
        } count allCurators;
    }] call CFUNC(addEventhandler);
};


private _fnc_flattenArray = {
    private _return = [];
    {
        if (_x isEqualType []) then {
            _x params ["_class", "_count"];
            for "_i" from 1 to _count do {
                _return pushBack _class;
            };
        } else {
            _return pushBack _x;
        };
    } count _this;
};
GVAR(unitPoolFriendly) = [];
GVAR(vehiclePoolFriendly) = [];
GVAR(airPoolFriendly) = [];

GVAR(unitPoolEnemy) = ["O_soldierU_A_F", "O_soldierU_AAR_F", "O_soldierU_AAA_F", "O_soldierU_AAT_F", "O_soldierU_AR_F", "O_soldierU_medic_F", "O_engineer_U_F", "O_soldierU_exp_F", "O_soldierU_GL_F", "O_Urban_HeavyGunner_F", "O_soldierU_M_F", "O_soldierU_AA_F", "O_soldierU_AT_F", "O_soldierU_repair_F", "O_soldierU_F", "O_soldierU_LAT_F", "O_Urban_Sharpshooter_F", "O_soldierU_SL_F", "O_soldierU_TL_F"];
GVAR(vehiclePoolEnemy) = ["O_MBT_02_cannon_F", "O_APC_Tracked_02_cannon_F", "O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F"];
GVAR(airPoolEnemy) = ["O_Heli_Light_02_F"];
GVAR(sniperPoolEnemy) = ["O_sniper_F"];
GVAR(staticPoolEnemy) = ["O_GMG_01_F", "O_HMG_01_F"];
GVAR(staticHighPoolEnemy) = ["O_GMG_01_high_F", "O_HMG_01_high_F"];
GVAR(staticMortarEnemy) = ["O_Mortar_01_F"];

GVAR(unitPoolRebels) = [];
GVAR(vehiclePoolRebels) = [];

GVAR(unitPoolCiv) = [];
GVAR(vehiclePoolCiv) = [];

GVAR(enemySide) = East;

GVAR(centerPos) = [worldSize/2, worldSize/2];
GVAR(locations) = [];
{
    private _locName = text _x;
    private _locPos = getpos _x;
    _locPos set [2,0];
    if (_locPos distance (getmarkerpos GVAR(baseMarker)) > 2500) then {
        GVAR(locations) pushBack _x
    };
    nil
} count (nearestLocations [GVAR(centerPos), ["NameCityCapital","NameCity","NameVillage"], worldSize]);

GVAR(locations) call CFUNC(shuffleArray);

["ACE_handcuffUnit", {
    (_this select 0) params ["_unit", "_state"];
    if !(local _unit) exitWith {};
    [_unit, _state] call ace_captives_fnc_setHandcuffed;
}] call CFUNC(addEventhandler);

GVAR(taskID) = 0;

DFUNC(taskName) = {
    params ["_name"];
    _name = _name + str GVAR(taskID);
    GVAR(taskID) = GVAR(taskID) + 1;
    _name
};
