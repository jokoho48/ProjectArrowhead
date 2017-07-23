#define PREFIX ProjectArrowhead
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

// #define ISDEV

#include "\tc\CLib\addons\CLib\macros.hpp"



#define poolWest 0
#define poolEast 1
#define poolGuer 2
#define poolCiv  3

#define NOCAHE(var) var setVariable [QEGVAR(Caching,onCache), true, true]
#define NOCLEAN(var) var setVariable [QCGVAR(noClean), true, true];
