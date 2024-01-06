%This function should be redone to be more robust as it currently is a very
%manual calculation.
%https://soggi.ca/wordpress/wp-content/uploads/2020/09/ServoTorqueCalcArticle_App.pdf

function min_torque = servo_torque(plane)

%Empennage
CD = 1;
v= max(plane.cruise_properties.speed2, plane.cruise_properties.speed3);
rho = plane.physics.air_density30;
flap_size_emp = 0.3;
max_deflection = 30;
L_emp = 0.539;
chord_emp = plane.horz_stabiliser.chord_root*flap_size_emp;
min_torque_emp = CD*rho*v^2*L_emp*chord_emp^2*sind(max_deflection)*...
    tand(max_deflection)/(4*tand(max_deflection));
min_torque_emp = min_torque_emp*10.2*1.25; %convert to kg*cm, add safety factor

%Wing

L_wing = (plane.wing.span-0.762);
flap_size_wing = 0.2;
chord_wing = plane.wing.chord_root*flap_size_wing;
min_torque_wing = CD*rho*v^2*L_wing*chord_wing^2*sind(max_deflection)*...
    tand(max_deflection)/(4*tand(max_deflection));
min_torque_wing = min_torque_wing*10.2*1.25; %convert to kg*cm, add safety factor



% Torque (oz.-in) = 8.5E-6 * (C2 V2 L sin(S1) tan(S1) / tan(S2))
% 
%                         Where:
% 
% §  C = Control surface chord in cm
% 
% §  L = Control surface length in cm
% 
% §  V = Speed in MPH
% 
% §  S1 = Max control surface deflection in degrees
% 
% §  S2 = Max servo deflection in degrees
% 

8.5*10^(-6)*((4.236)^2*(2.23694*v)^2*73.8*sind(30)*tand(30)/tand(30));
end