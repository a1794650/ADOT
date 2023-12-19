%Name:    Isaac Nakone
%Date:    11/12/2023
%Purpose: This calculates the score for mission 2, as well as updating the
%         relevant parameters of the aircraft.

function score2(plane)
    
    %calculate the score for mission 2 and store in the plane variable.
    plane.score.M2 = 1.0 + plane.payload.mass2...
                     /(3*plane.cruise_properties.time2)/...
                     plane.score.baseline2;
end
