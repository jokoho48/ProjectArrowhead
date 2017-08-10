#define PREFIX PRAW
#define PATH paw
#define MOD ProjectArrowhead

// define Version Information
#define MAJOR 0
#define MINOR 1
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
#define QMFUNC(var) QUOTE(MFUNC(var))
#define MGVAR(var) EGVAR(Common,var)
#define QMGVAR(var) QUOTE(MGVAR(var))

#define GETCLASS(var1,var2) ([var1, var2] call FUNC(getClassName))
