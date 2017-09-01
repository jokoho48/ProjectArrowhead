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
params [["_obj", objNull, [objNull]]];

if (_obj isKindOf "Air") exitWith {
    LOG("fn_setUnitSurrender: Object is AIR type. Can't surrender.");
    private _grp = group _obj;

    {
        deleteWaypoint _x;
        nil
    } count waypoints _grp;
    private _wp = _grp addWaypoint [[-1000,-1000,-1000], 10];
    _wp setWaypointStatements ["true", 'GARBAGE(group this)'];
    _grp setCurrentWaypoint _wp;
};

if (_obj isKindOf "LandVehicle" || {_obj isKindOf "Ship"}) exitWith {
    if (_obj isKindOf "StaticWeapon") then {
        {
            moveOut _x;
            _x setBehaviour "CARELESS";
            [_x, true] call FUNC(setUnitHostage);
            DUMP(typeOf _x + " surrenders.");
            nil
        } count (crew _obj);
    } else {
        private _driver = driver _obj;
        (group _driver) setVariable [QGVAR(ExitPatrol), true];
        _obj limitSpeed 0;

        [{
            (group _driver) leaveVehicle _obj;
            {
                moveOut _x;
                _x setBehaviour "CARELESS";
                doStop _x;
                [_x, true] call FUNC(setUnitHostage);
                DUMP(typeOf _x + " surrenders.");
                nil
            } count (crew _obj);
        }, 4, [_obj, _driver]] call CFUNC(wait);
    };
    true
};

[_obj] joinSilent grpNull;
(group _obj) setVariable [QGVAR(ExitPatrol), true];
_obj setBehaviour "CARELESS";
doStop _obj;
[_obj,true] call ace_captives_fnc_setSurrendered;
DUMP(typeOf _obj + " surrenders.");
true
