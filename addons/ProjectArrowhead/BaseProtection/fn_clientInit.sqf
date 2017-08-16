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
    [QGVAR(Fired), {(getPos CLib_Player) call MFUNC(inBase)}, 1] call CFUNC(cachedCall);
}, {
    ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "Use the shooting range to try out weapons."]] call CFUNC(localEvent);
}, ["priority", 0,"showWindow", false,"shortcut", "DefaultAction"]] call CFUNC(addAction);

["ace_explosives_place", {
    params ["_obj"];
    if ([QGVAR(Fired), {(getPos CLib_Player) call MFUNC(inBase)}, 1] call CFUNC(cachedCall)) then {
        if (local (nearestObject [getPos _obj, "Man"])) then {
            ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "Use the shooting range to try out weapons."]] call CFUNC(localEvent);
        };
        deleteVehicle _obj;
    };
}] call CBA_fnc_addEventHandler;
