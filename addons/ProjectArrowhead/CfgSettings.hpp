class ProjectArrowhead {
    MainAOSize = 2;
    sideMissionDelay = 0;
    class sideMissions {
        class locateHastage {
            function = "ProjectArrowhead_Missions_fnc_locateHastage";
        };
    };
    missionAmount = 10;
    class mainMissions {
        class clearTown {
            function = "ProjectArrowhead_Missions_fnc_clearTown";
        };
    };

    class randomEvents {
        class earthQuake {
            function = "ProjectArrowhead_randomEvents_fnc_earthQuake"; // FFS arma why you need that spawned
        };
        class rebelAttack {
            function = "ProjectArrowhead_randomEvents_fnc_rebelAttack";
        };
        class airAttack {
            function = "ProjectArrowhead_randomEvents_fnc_airAttack";
        };
    };
    class RandomCampPatrols {
        randomCampCount = 10;
        randomPatrolCount = 10;
        randomPatrolVehCount = 4;
    };

    class Caching {
        Group = 2000;
        Vehicle = 2500;
        EmptyVehicle = 1000;
        Prop = 250;
        IsMoving = 2.2;
        useViewDistance = 0;
    };
};
