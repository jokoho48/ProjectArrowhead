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
params [["_obj", objNull, [objNull]]];

if (typeOf _obj isKindOf "Air") exitWith {
    LOG("fn_setUnitSurrender: Object is AIR type. Can't surrender.");
};

if (typeOf _obj isKindOf "LandVehicle" || {typeOf _obj isKindOf "Ship"}) exitWith {
    if (typeOf _obj isKindOf "StaticWeapon") then {
        {
            moveOut _x;
            _x setBehaviour "CARELESS";
            [_x,true] call ace_captives_fnc_setSurrendered;
            [0,"%1 surrenders.",typeOf _x] call SEN_fnc_log;
            nil
        } count (crew _obj);

    } else {
        private _driver = driver _obj;
        _driver setVariable ["SEN_patrol_exit", true];
        _obj limitSpeed 0;
        sleep 2;
        group _driver leaveVehicle _obj;
        sleep 5;
        {
            _x setBehaviour "CARELESS";
            doStop _x;
            [_x,true] call ace_captives_fnc_setSurrendered;
            [0,"%1 surrenders.",typeOf _x] call SEN_fnc_log;
            nil
        } count units (group _driver);
    };
    true
};

[_obj] joinSilent grpNull;
_obj setVariable ["SEN_patrol_exit",true];
_obj setBehaviour "CARELESS";
doStop _obj;
[_obj,true] call ace_captives_fnc_setSurrendered;
[0,"%1 surrenders.",typeOf _obj] call SEN_fnc_log;
true
