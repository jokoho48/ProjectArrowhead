#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Let units Occupy nearby Building

    Parameter(s):
    0: Center Position <Position>
    1: Unit Array <Array<Object>, Group>
    2: Radius <Number>
    3: Randomise Positions <Boolean>

    Returns:
    None
*/
RUNTIMESTART;
params [
    ["_pos", [0,0,0], [[]]],
    ["_units", [], [[], grpNull]],
    ["_radius", 50, [0]],
    ["_random", false, [true]]
];
private _buildings = if (_radius < 60) then {
    nearestObjects [_pos, ["Building"], _radius];
} else {
    private _temp = nearestObjects [_pos, ["Building"], _radius];
    _temp = _temp call CFUNC(shuffleArray);
    _temp
};
if (_buildings isEqualTo []) exitWith {DUMP("NoBuildings Found")};
private _buildingPos = [];
{
    _buildingPos append (_x buildingPos -1);
    nil
} count _buildings;

if (_random) then {
    _buildingPos = _buildingPos call CFUNC(shuffleArray);
};

{
    _x setPos (_buildingPos param [_forEachIndex, formationPosition _x]);
} forEach _units;

{
    _x disableAI "AUTOCOMBAT";
    _x disableAI "PATH";
} count _units;
RUNTIME("Occupy");
nil
