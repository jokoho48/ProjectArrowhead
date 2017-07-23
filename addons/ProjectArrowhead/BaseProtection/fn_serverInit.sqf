#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:
    Server Init for BaseProtection

    Parameter(s):
    None

    Returns:
    None
*/

private _trgE = createTrigger ["EmptyDetector", (getMarkerPos "Base")];
private _trgG = createTrigger ["EmptyDetector", (getMarkerPos "Base")];
_trgE setTriggerArea [1000, 1000, 0, false, 200];
_trgG setTriggerArea [1000, 1000, 0, false, 200];
_trgE setTriggerActivation ["EAST", "PRESENT", true];
_trgG setTriggerActivation ["GUER", "PRESENT", true];
_trgE setTriggerStatements ["this", "{if (side _x isEqualTo east) then {deleteVehicle _x}} count thisList", ""];
_trgG setTriggerStatements ["this", "{if (side _x isEqualTo independent) then {deleteVehicle _x}} count thisList", ""];
