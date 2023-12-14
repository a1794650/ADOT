%Name:    Denis Vasilyev
%Date:    12/12/2023
%Purpose: This calculates the score for mission 3, as well as updating the
%         relevant parameters of the aircraft.

function score3(plane)
    
    %calculate the score for mission 3 and store in the plane variable.

    plane.cruise_properties.laps3 = 5*60/plane.cruise_properties.time3;
 
    plane.score.M3 = 2.0 + plane.cruise_properties.laps3*...
        plane.passengers.total/plane.battery.capacity/plane.score.baseline3;

end