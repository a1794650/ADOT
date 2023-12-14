%Name:    Isaac Nakone
%Date:    11/12/2023
%Purpose: This calculates the score for mission 2, as well as updating the
%         relevant parameters of the aircraft.

function S = score(plane, vars)

    if (nargin == 2)

        vars2aircraft(vars,plane); %Need to do this to update plane object.

    end

    calcs(plane);

    plane.score.M1 = 1.0; %assume this by default;

    score2(plane);

    score3(plane);

    plane.score.total = plane.score.M1 + plane.score.M1 + plane.score.M3;


    S = plane.score.total;
    
end