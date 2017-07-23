#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:
    Client Init for BaseProtection

    Parameter(s):
    None

    Returns:
    None
*/

["", CLib_Player, 0, {
    [QGVAR(Fired), {((getMarkerPos EGVAR(Common,baseMarker)) distance CLib_Player) >= 300}, 10] call CFUNC(cachedCall);
}, {
    ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "FUCKING IDIOT!"]] call CFUNC(localEvent);
}, ["priority", 0,"showWindow", false,"shortcut", "DefaultAction"]] call CFUNC(addAction);
