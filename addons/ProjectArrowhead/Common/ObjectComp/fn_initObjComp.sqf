#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:
    Init of SimpleObjectFramework

    Parameter(s):
    None

    Returns:
    None
*/
if (isServer) then {
    GVAR(objComp) = true call CFUNC(createNamespace); // we need a Global Namespace because Only the Server have the Mod Config Classes
    {
        {
            _x call FUNC(readObjectComp);
            nil
        } count (configProperties [_x >> "CfgObjectComp", "isClass _x", true]);
        nil
    } count [configFile, campaignConfigFile, missionConfigFile];
    publicVariable QGVAR(objComp);
};
