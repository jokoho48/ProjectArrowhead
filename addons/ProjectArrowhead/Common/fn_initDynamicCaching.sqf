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
["missionStarted", {
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
}] call CFUNC(addEventhandler);
