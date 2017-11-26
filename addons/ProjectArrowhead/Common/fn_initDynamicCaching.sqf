#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Init for Dynamic Caching Settings

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

    GVAR(oldFOV) = -999;
    [{
        private _fov = (floor(call CFUNC(getFOV) * 100))/100;
        if (_fov != GVAR(oldFOV)) then {
            ["FOVChanged", [call CFUNC(getFOV), GVAR(oldFOV)]] call CFUNC(localEvent);
            GVAR(oldFOV) = _fov;
        };
    }, 1] call CFUNC(addPerFrameHandler);

    GVAR(useViewDistance) = ([CFGPRAW2(Caching,useViewDistance), 1] call CFUNC(getSetting)) isEqualTo 1;
    if (GVAR(useViewDistance)) then {
        ["FOVChanged", {
            [{
                private _distance = (viewDistance - (viewDistance * fog));
                "Group" setDynamicSimulationDistance _distance;
                "Vehicle" setDynamicSimulationDistance _distance;
            }] call CFUNC(execNextFrame);
        }] call CFUNC(addEventhandler);
    };
    // fix UAVs
    ["getConnectedUAVChanged", {
        (_this select 0) params ["_new", "_old"];
        _new enableDynamicSimulation false;
        _old enableDynamicSimulation false;
        _new triggerDynamicSimulation true;
        _old triggerDynamicSimulation true;
    }] call CFUNC(addEventhandler);
}] call CFUNC(addEventhandler);
