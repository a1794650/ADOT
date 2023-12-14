%Name:    Isaac Nakone
%Date:    11/12/2023
%Purpose: This is a function which takes in an 
%         aircraft and outputs the clearance
%         in the battery capacity.

%Description from constraint set:
%   Battery Capacity versus cruise required (BC).


function BC = con_BC( plane)

    
    BC = plane.battery.capacity -...
        plane.cruise_properties.power*...
        (5 + plane.misc_properties.time_safety)*...
        1.25*plane.units.W2mW*plane.units.min2h/...
        plane.battery.voltage; %This will be in mAh. (or is it mWh)
end