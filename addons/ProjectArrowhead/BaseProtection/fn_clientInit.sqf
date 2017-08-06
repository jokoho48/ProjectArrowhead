#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Client Init for BaseProtection

    Parameter(s):
    None

    Returns:
    None
*/

["", CLib_Player, 0, {
    [QGVAR(Fired), {((getMarkerPos MGVAR(baseMarker)) distance CLib_Player) >= 300}, 10] call CFUNC(cachedCall);
}, {
    ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "FUCKING IDIOT!"]] call CFUNC(localEvent);
}, ["priority", 0,"showWindow", false,"shortcut", "DefaultAction"]] call CFUNC(addAction);

["ace_explosives_place", {
    params ["_obj"];
    if ((_obj distance (getmarkerpos MGVAR(baseMarker))) < 300) then {
        if (local (nearestObject [getPos _obj, "Man"])) then {
            ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "FUCKING IDIOT!"]] call CFUNC(localEvent);
        };
        deleteVehicle _obj;
    };
}] call CBA_fnc_addEventHandler;
