%Name:    Isaac Nakone
%Date:    11/12/2023
%Purpose: This is a function which takes in an 
%         aircraft and outputs the variables 
%         over which the maximisation occurs.

%NOTE: I believe this is called a "function wrapper" in the field.

function vars = aircraft2vars(plane)
    vars(1)  = plane.passengers.width;     
    vars(2)  = plane.passengers.total;
    vars(3)  = plane.msc.mass;
    vars(4)  = plane.wing.taper_ratio;
    vars(5)  = plane.wing.chord_root;
    vars(6)  = plane.fuselage.width;
    vars(7)  = plane.wing.span;
    vars(8)  = plane.wing.position;
    vars(9)  = plane.horz_stabiliser.chord_root;
    vars(10) = plane.horz_stabiliser.span;
    vars(11) = plane.misc_properties.aspect_ratio;
end
