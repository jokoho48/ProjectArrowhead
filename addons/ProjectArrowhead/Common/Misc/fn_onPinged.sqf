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
params ["", "_unit"];

private _pingCount = _unit getVariable QGVAR(curatorPingCount);
private _lastPingTime = _unit getVariable QGVAR(lastPingTime);

if (isnil "_pingCount") then {
    _unit setVariable [QGVAR(curatorPingCount), 1, false];
    _unit setVariable [QGVAR(lastPingTime), time, false];
} else {
    _pingCount = _pingCount + 1;

    if (_lastPingTime <= time - 20) then {
        _unit setVariable [QGVAR(lastPingTime), time, false];
        _unit setVariable [QGVAR(lastPingTime), 1, false];
    } else {
        if (_pingCount in [3,4]) then {
            ["DisplayHint", _unit, ["YOU HAVE ANGERD ZEUS", "wait 20s before pressing the zeus ping button again, or die."]] call CFUNC(targetEvent);
        };
        if (_pingCount >= 5) then {
            _unit setDamage 1;
            _unit setVariable [QGVAR(curatorPingCount), nil, false];
            _unit setVariable [QGVAR(lastPingTime), nil, false];
        } else {
            _unit setVariable [QGVAR(lastPingTime), time, false];
            _unit setVariable [QGVAR(curatorPingCount), _pingCount, false];
        };
    };
};
