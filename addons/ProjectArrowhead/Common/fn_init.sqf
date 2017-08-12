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
GVAR(baseMarker) = "Base";    // TODO: make settings
["DisplayHint", {
    (_this select 0) params ["_headerText", "_mainText", ["_color", "#ff0000"]];
    [
        format [
            "<t size='1' color=''>%1</t><br/><t size='0.6'>%2</t>",
            _headerText,
            _mainText,
            _color
        ]
    ] spawn BIS_fnc_dynamicText;
}] call CFUNC(addEventhandler);

["entityCreated", {
    (_this select 0) params ["_obj"];
    if (_obj isKindOf "ModuleCurator_F") then {
        _obj addEventHandler ["CuratorPinged", { _this call FUNC(onPinged); }];
    };
}] call CFUNC(addEventhandler);

["entityCreated", {
    (_this select 0) params ["_obj"];
    if !(_obj getVariable [QEGVAR(Caching,onCache), false] || (group _obj) getVariable [QEGVAR(Caching,onCache), false]) then {
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

GVAR(unitPoolFriendly) = [];    // TODO: Make setting
GVAR(vehiclePoolFriendly) = [];    // TODO: Make setting
GVAR(airPoolFriendly) = [];    // TODO: Make setting

GVAR(unitPoolEnemy) = ["O_soldierU_A_F", "O_soldierU_AAR_F", "O_soldierU_AAA_F", "O_soldierU_AAT_F", "O_soldierU_AR_F", "O_soldierU_medic_F", "O_engineer_U_F", "O_soldierU_exp_F", "O_soldierU_GL_F", "O_Urban_HeavyGunner_F", "O_soldierU_M_F", "O_soldierU_AA_F", "O_soldierU_AT_F", "O_soldierU_repair_F", "O_soldierU_F", "O_soldierU_LAT_F", "O_Urban_Sharpshooter_F", "O_soldierU_SL_F", "O_soldierU_TL_F"];    // TODO: Make setting
GVAR(vehiclePoolEnemy) = ["O_MBT_02_cannon_F", "O_APC_Tracked_02_cannon_F", "O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F"];    // TODO: Make setting
GVAR(airPoolEnemy) = ["O_Heli_Light_02_F"];    // TODO: Make setting
GVAR(sniperPoolEnemy) = ["O_sniper_F"];    // TODO: Make setting
GVAR(staticPoolEnemy) = ["O_GMG_01_F", "O_HMG_01_F"];    // TODO: Make setting
GVAR(staticHighPoolEnemy) = ["O_GMG_01_high_F", "O_HMG_01_high_F"];    // TODO: Make setting
GVAR(staticMortarEnemy) = ["O_Mortar_01_F"];    // TODO: Make setting

GVAR(unitPoolRebels) = [];    // TODO: Make setting
GVAR(vehiclePoolRebels) = [];    // TODO: Make setting

GVAR(unitPoolCiv) = [];    // TODO: Make setting
GVAR(vehiclePoolCiv) = [];    // TODO: Make setting

GVAR(enemySide) = East;    // TODO: Make setting

GVAR(centerPos) = [worldSize/2, worldSize/2];
GVAR(worldSize) = (worldSize/2);
GVAR(locations) = [];
GVAR(blackListLocations) = ["Agia Triada", "Telos", "Gravia", "Koroni", "Ifestiona", "Agios Petros"];    // TODO: Make setting
{
    private _locName = text _x;
    private _locPos = getPos _x;
    _locPos set [2,0];
    if !(_locPos call FUNC(nearBase) || (_locName in GVAR(blackListLocations))) then {
        GVAR(locations) pushBack _x;
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

["excuteFunction", {
    (_this select 0) params [["_function", ""], "_args"];
    _args call (missionNamespace getVariable [_function, {LOG("Error Function not found")}]);
}] call CFUNC(addEventhandler);

["excuteCode", {
    (_this select 0) params [["_code", {}], "_args"];
    _args call _code;
}] call CFUNC(addEventhandler);

{
    private _data = [format[CFGPRAW2(Caching,%1), _x], -1] call CFUNC(getSetting);
    if (_data != -1) then {
        _x setDynamicSimulationDistance _data;
    };
    nil
} count ["Group", "Vehicle", "EmptyVehicle", "Prop"];

{
    private _data = [format[CFGPRAW2(Caching,%1), _x], -1] call CFUNC(getSetting);
    if (_data != -1) then {
        _x setDynamicSimulationDistanceCoef _data;
    };
    nil
} count ["IsMoving"];


GVAR(useViewDistance) = ([CFGPRAW2(Caching,useViewDistance), 1] call CFUNC(getSetting)) isEqualTo 1;
if (GVAR(useViewDistance)) then {
    ["cameraViewChanged", {
        (_this select 0) params ["_new", "_old"];
        if (cameraView isEqualTo _new) then {
            "Group" setDynamicSimulationDistance (viewDistance - (viewDistance * fog));
        } else {
            "Group" setDynamicSimulationDistance ((viewDistance * 0.8) - (viewDistance * fog));
        };
    }] call CFUNC(addEventhandler);
};



DFUNC(createMarker) = {
#ifdef ISDEV
    params ["_pos", "_icon", "_color", "_dir", "_text"];
    private _mrk = createMarker [format[QGVAR(%1_%2_%3_%4), _pos, _icon, _color, _dir, _text], _pos];
    _mrk setMarkerType _icon;
    if !(isNil "_color") then {
        _mrk setMarkerColor _color;
    };
    if !(isNil "_dir") then {
        _mrk setMarkerDir (180 - _dir);
    };
    if !(isNil "_text")  then {
        _mrk setMarkerText _text;
    };
    _mrk
#endif
};
