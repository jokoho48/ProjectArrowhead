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
GVAR(baseMarker) = "Base";    // TODO: make settings
GVAR(blackListLocations) = ["Kalithea", "Agia Triada", "Telos", "Gravia", "Koroni", "Ifestiona", "Agios Petros", "Ekali"];    // TODO: Make setting

GVAR(unitPoolFriendly) = [];    // TODO: Make setting
GVAR(vehiclePoolFriendly) = [];    // TODO: Make setting
GVAR(airPoolFriendly) = [];    // TODO: Make setting

GVAR(unitPoolEnemy) = ["O_soldierU_A_F", "O_soldierU_AAR_F", "O_soldierU_AAA_F", "O_soldierU_AAT_F", "O_soldierU_AR_F", "O_soldierU_medic_F", "O_engineer_U_F", "O_soldierU_exp_F", "O_soldierU_GL_F", "O_Urban_HeavyGunner_F", "O_soldierU_M_F", "O_soldierU_AA_F", "O_soldierU_AT_F", "O_soldierU_repair_F", "O_soldierU_F", "O_soldierU_LAT_F", "O_Urban_Sharpshooter_F", "O_soldierU_SL_F", "O_soldierU_TL_F"];    // TODO: Make setting
GVAR(vehiclePoolEnemy) = ["O_MBT_02_cannon_F", "O_APC_Tracked_02_cannon_F", "O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F"];    // TODO: Make setting
GVAR(airPoolEnemy) = ["O_Heli_Light_02_F"];    // TODO: Make setting
GVAR(sniperPoolEnemy) = ["O_sniper_F"];    // TODO: Make setting
GVAR(staticPoolEnemy) = ["O_GMG_01_F", "O_HMG_01_F"];    // TODO: Make setting
GVAR(staticHighPoolEnemy) = ["O_GMG_01_high_F", "O_HMG_01_high_F"];    // TODO: Make setting
GVAR(staticMortarEnemy) = ["O_Mortar_01_F"];    // TODO: Make setting

GVAR(unitPoolRebels) = [];    // TODO: Make setting
GVAR(vehiclePoolRebels) = [];    // TODO: Make setting

GVAR(unitPoolCiv) = [];    // TODO: Make setting
GVAR(vehiclePoolCiv) = [];    // TODO: Make setting

GVAR(enemySide) = East;    // TODO: Make setting
