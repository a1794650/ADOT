%Name:        Denis Vasilyev
%Date:        24/12/2023
%Description: This finds the stall speed for the aircraft.
%Inputs:
%       (1) V_CR  == the cruise velocity.


function [V_stall2, V_stall3] = Stall_Speed(plane)
    V_stall2 = sqrt((2*plane.mass2*plane.physics.gravity)/...
        (plane.physics.air_density0*plane.wing.area*plane.wing.coeff_lift_max));
    V_stall3 = sqrt((2*plane.mass3*plane.physics.gravity)/...
        (plane.physics.air_density0*plane.wing.area*plane.wing.coeff_lift_max));
end
