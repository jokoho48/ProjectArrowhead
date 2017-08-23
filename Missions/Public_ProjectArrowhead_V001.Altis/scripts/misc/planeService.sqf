/*
* Author: alganthe
* Handler for the vehicle service pad (Planes)
*
* Arguments:
* 0: Vehicle to be serviced <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_vehicle"];

if (_vehicle isKindOf "Plane") then {

    _vehicle engineOn false;
    _vehicle vehicleChat "Servicing started, we should be finished in 2 minutes";
    _vehicle setFuel 0;


    //---------- REPAIRING
    sleep 120;
    _vehicle vehicleChat "*crew is working*";



    //---------- FINISHED
    sleep 10;
    _vehicle setDamage 0;
    _vehicle setFuel 0.1;
    _vehicle vehicleChat "We've repaired her and put some fuel in to get you going.";



    sleep 2;
    _vehicle vehicleChat "Good luck out there soldier!";

} else {
    _vehicle vehicleChat "Sorry, we're only equipped for fixed wings.";

};
