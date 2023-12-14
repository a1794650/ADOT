%Name:        Isaac Nakone, Denis Vasilyev, Harry Rowton, Jingya Liu 
%Date:        10/12/2023
%Description: This finds the power at cruise.
%Inputs:
%       (1) V_CR  == the cruise velocity.


function P_CR = powerAtCruise(V_CR, plane)

     V_CR_2 = V_CR(1);
     V_CR_3 = V_CR(2);

    [CD_2,CD_3] = coeff_drag(V_CR_2, V_CR_3, plane);
  
    [e2,e3] = oswald_efficiency(V_CR_2,V_CR_3, plane);
    [C_L_CR_2, C_L_CR_3] = C_LAtCruise(V_CR_2,V_CR_3, plane);
    
    P_CR_2 = 0.5*plane.physics.air_density30*V_CR_2^3*...
            plane.wing.area*(CD_2 +...
            2*C_L_CR_2^2/...
            pi/plane.wing.aspect_ratio/e2 );


    P_CR_3 = 0.5*plane.physics.air_density30*V_CR_3^3*...
            plane.wing.area*(CD_3 +...
            2*C_L_CR_3^2/...
            pi/plane.wing.aspect_ratio/e3 );

    P_CR = [P_CR_2;P_CR_3];
end
