#include "\tc\CLib\addons\CLib\ModuleMacros.hpp"

class CfgCLibModules {
    class ProjectArrowhead {
        dependency[] = {"CLib"};
        path = "\paw\ProjectArrowhead\addons\ProjectArrowhead"; // TODO add Simplifyed Macro for this

        MODULE(BaseProtection) {
            dependency[] = {"ProjectArrowhead/Common"};
            FNC(clientInit);
            FNC(serverInit);
        };

        MODULE(Common) {
            MODULE(Misc) {
                FNC(fillLocations);
                FNC(flattenArray);
                FNC(getClosePlayers);
                FNC(getEnemyStrength);
                FNC(onPinged);
                FNC(setUnitSurrender);
                FNC(setUnitHostage);
                FNC(taskName);
            };

            MODULE(ObjectComp) {
                FNC(createObjectComp);
                FNC(initObjComp);
                FNC(readObjectComp);
            };

            MODULE(Position) {
                FNC(findHousePos);
                FNC(findOverwatchPos);
                FNC(findPosArray);
                FNC(findRuralFlatPos);
                FNC(findRuralHousePos);
                FNC(findTriPos);
                FNC(getLocation);
                FNC(inArea);
                FNC(nearBase);
                FNC(selectRandomPos);
            };

            MODULE(Spawn) {
                FNC(getClassName);
                FNC(spawnGroup);
                FNC(spawnSniper);
                FNC(spawnStatic);
                FNC(spawnTower);
            };

            MODULE(UnitMovment) {
                FNC(occupyBuilding);
                FNC(serverInitUnitMovment);
                FNC(setPatrolInf);
                FNC(setPatrolVeh);
                FNC(taskPatrol);
            };

            FNC(clientInit);
            FNC(init);
            FNC(initDynamicCaching);
            FNC(serverInit);
            FNC(Settings);

        };

        MODULE(IED) {
            dependency[] = {"ProjectArrowhead/Common"};
            FNC(serverInit);
        };

        MODULE(MainAO) {
            dependency[] = {"ProjectArrowhead/Common"};
            FNC(selectMainMission);
            FNC(serverInit);
        };

        MODULE(Missions) {
            dependency[] = {"ProjectArrowhead/Common"};
            MODULE(MainAO) {
                FNC(clearTown);
                FNC(initMainAO);
            };
            FNC(init);
        };

        MODULE(RandomCampPatrols) {
            dependency[] = {"ProjectArrowhead/Common"};
            FNC(serverInit);
            FNC(spawn);
        };

        MODULE(RandomEvents) {
            FNC(init);
        };

        MODULE(SideMission) {
            dependency[] = {"ProjectArrowhead/Common"};
            FNC(selectSideMission);
            FNC(serverInit);
        };
    };
};
