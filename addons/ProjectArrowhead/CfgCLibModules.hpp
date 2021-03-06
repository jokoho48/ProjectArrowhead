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
            dependency[] = {"CLib"};
            MODULE(Misc) {
                FNC(aliveGroup);
                FNC(callMissionData);
                FNC(fillLocations);
                FNC(flattenArray);
                FNC(getClosePlayers);
                FNC(isAwake);
                FNC(isKindOf);
                FNC(onPinged);
                FNC(pushBackToGarbageCollector);
                FNC(readOutMissionData);
                FNC(replaceObjects);
                FNC(selectMissionData);
                FNC(setUnitSurrender);
                FNC(setUnitHostage);
                FNC(taskName);
            };

            MODULE(ObjectComp) {
                FNC(createObjectComp);
                FNC(exportObjectComp);
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
                FNC(getPlayerTarget);
                FNC(getWorldEdgePos);
                FNC(inArea);
                FNC(inBase);
                FNC(isOnMap);
                FNC(nearBase);
                FNC(nearPositions);
                FNC(selectRandomPos);
            };

            MODULE(Spawn) {
                FNC(getClassName);
                FNC(spawnGroup);
                FNC(spawnReinforcements);
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
            MODULE(SideMissions) {
                MODULE(CollectIntel) {
                    FNC(collectIntel);
                    FNC(initCollectIntel);
                };
                MODULE(DestroyComTower) {
                    FNC(destroyComTower);
                    FNC(initDestroyComTower);
                };
                MODULE(LocateHostage) {
                    FNC(initHostage);
                    FNC(locateHostage);
                };
                MODULE(EliminateOfficer) {
                    FNC(eliminateOfficer);
                    FNC(initEliminateOfficer);
                };
                MODULE(DestroyMortar) {
                    FNC(destroyMortar);
                    FNC(initDestroyMortar);
                };
            };

            FNC(init);
        };

        MODULE(RandomCampPatrols) {
            dependency[] = {"ProjectArrowhead/Common"};
            FNC(serverInit);
            FNC(spawn);
        };

        MODULE(RandomEvents) {
            FNC(airAttack);
            FNC(init);
            FNC(rebelAttack);
            FNC(selectRandomEvent);
            FNC(serverInit);
        };

        MODULE(SideMission) {
            dependency[] = {"ProjectArrowhead/Common"};
            FNC(selectSideMission);
            FNC(serverInit);
        };
    };
};
