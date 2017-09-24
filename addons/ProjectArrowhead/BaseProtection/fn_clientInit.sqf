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

DFUNC(nearBase) = {
    [QGVAR(Fired), {
        (getPos CLib_Player) call MFUNC(inBase) && !GVAR(enemyAtBase)
    }, [], 1] call CFUNC(cachedCall);    
};

DFUNC(notCarrying) = {
    [QGVAR(notCarrying), {
        private _animState = animationState CLib_Player;
        ((_animState find "acin") == -1) && {(_animState find "sras") > -1}
    }, [], 0.2] call CFUNC(cachedCall);
};

/*
    Having this on default action is blocking features like ace dragging/carrying.
    Now using temporary fix with animation names.
*/

{
    ["", CLib_Player, 0, {call FUNC(nearBase) && {call FUNC(notCarrying)}}, {
        ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "Use the shooting range to try out weapons."]] call CFUNC(localEvent);
    }, ["priority", 0,"showWindow", false, "shortcut", _x]] call CFUNC(addAction);

    nil
} count ["DefaultAction", "throw"];

/*
    Getting reports that explosives are being deleted outside of base.
    Disabing this feature for now.
    Perhaps better to tie this detonation and not placement?

    ["ace_explosives_place", {
        params ["_obj"];
        if (call FUNC(nearBase)) then {
            if (local (nearestObject [getPos _obj, "Man"])) then {
                ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "Use the shooting range to try out weapons."]] call CFUNC(localEvent);
            };
            deleteVehicle _obj;
        };
    }] call CBA_fnc_addEventHandler;
*/

["ace_advanced_throwing_throwFiredXEH", {
    params [
        "_unit", // unit
        "", // weapon
        "", // muzzle
        "", // mode
        "", // ammo
        "", // magazine
        "_activeThrowable" // projectile
    ];
    if (_unit == CLib_Player) then {
        if (call FUNC(nearBase)) then {
            ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "Use the shooting range to try out weapons."]] call CFUNC(localEvent);
            deleteVehicle _activeThrowable;
        };
    };
}] call CBA_fnc_addEventHandler;

GVAR(fireEHID) = -1;
DFUNC(firedEH) = {
    params ["_new", "_old"];
    if (GVAR(fireEHID) != -1) then {
        _old removeEventHandler ["FiredMan", GVAR(fireEHID)];
    };
    GVAR(fireEHID) = _new addEventHandler ["FiredMan", {
        params [
            "", // unit
            "", // weapon
            "", // muzzle
            "", // mode
            "", // ammo
            "", // magazine
            "_projectile" // projectile
        ];
        if (call FUNC(nearBase)) then {
            ["DisplayHint", ["WEAPON DISCHARGE IS NOT PERMITTED IN BASE!", "Use the shooting range to try out weapons."]] call CFUNC(localEvent);
            deleteVehicle _projectile;
        };
    }];
};
["playerChanged", {
    (_this select 0) params ["_new", "_old"];
    [_new, _old] call FUNC(firedEH);
}] call CFUNC(addEventhandler);
[CLib_Player, objNull] call FUNC(firedEH);
