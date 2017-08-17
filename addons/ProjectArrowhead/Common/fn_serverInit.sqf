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
if (isServer) then {
    GVAR(OverwatchCache) = true call CFUNC(createNamespace);
    publicVariable QGVAR(OverwatchCache);
};
GVAR(taskID) = 0;
["entityCreated", {
    (_this select 0) params ["_obj"];
    if !(_obj getVariable [QEGVAR(Caching,onCache), false] || (group _obj) getVariable [QEGVAR(Caching,onCache), false]) then {
        if !(simulationEnabled _obj) exitWith {};
        _obj enableDynamicSimulation true;
        (group _obj) enableDynamicSimulation true;
    };
    {
        _x addCuratorEditableObjects [[_obj], true];
    } count allCurators;
}] call CFUNC(addEventhandler);
