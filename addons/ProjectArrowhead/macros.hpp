#define PREFIX ProjectArrowhead
#define PATH paw
#define MOD ProjectArrowhead

// define Version Information
#define MAJOR 0
#define MINOR 2
#define PATCHLVL 0
#define BUILD 0

#ifdef VERSION
    #undef VERSION
#endif
#ifdef VERSION_AR
    #undef VERSION_AR
#endif
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD
#define VERSION MAJOR.MINOR.PATCHLVL.BUILD

#define ISDEV

#include "\tc\CLib\addons\CLib\macros.hpp"

#define NOCACHE(var) var setVariable [QEGVAR(Caching,onCache), true, true]
#define NOCLEAN(var) var setVariable [QCGVAR(noClean), true, true]

#define MFUNC(var) EFUNC(Common,var)
#define QMFUNC(var) QEFUNC(Common,var)
#define MGVAR(var) EGVAR(Common,var)
#define QMGVAR(var) QUOTE(MGVAR(var))

#define MISSIONCLASS missionConfigFile >> "ProjectArrowhead"

#define CFGPRAW(var) QUOTE(PREFIX/var)
#define CFGPRAW2(var1,var2) QUOTE(PREFIX/var1/var2)
#define CFGPRAW3(var1,var2,var3) QUOTE(PREFIX/var1/var2/var3)
#define CFGPRAW4(var1,var2,var3,var4) QUOTE(PREFIX/var1/var2/var3/var4)

#define GETCLASS(var1,var2) ([var1, var2] call MFUNC(getClassName))
#define GETCLASS2(var1,var2,var3) ([var1, [var2, var3]] call MFUNC(getClassName))

#define NEXTSIDEMISSION call EFUNC(SideMission,selectSideMission);
#define NEXTMAINAO call EFUNC(MainAO,selectMainMission);
#define GARBAGE(var) var call MFUNC(pushBackToGarbageCollector)
#ifdef ISDEV
    #define RUNTIMESTART private _debugStartTime = diag_tickTime
    #define RUNTIME(var) DUMP(var + " Needed: " + ((diag_tickTime - _debugStartTime) call CFUNC(toFixedNumber)) + " ms")

#else
    #define RUNTIMESTART /*Disabled*/
    #define RUNTIME(var) /*Disabled*/
#endif
