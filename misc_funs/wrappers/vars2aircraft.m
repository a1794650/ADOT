%Name:    Isaac Nakone
%Date:    11/12/2023
%Purpose: This is a function which takes in vars
%         and updates the aircraft


function vars2aircraft(vars, plane)
    plane.passengers.nwidth             = vars(1);  
    plane.passengers.total             = vars(2);
    plane.msc.mass                     = vars(3);
    plane.wing.taper_ratio             = vars(4);
    plane.wing.chord_root              = vars(5);
    plane.fuselage.width               = vars(6);
    plane.wing.span                    = vars(7);
    plane.wing.position                = vars(8);
    plane.horz_stabiliser.chord_root   = vars(9);
    plane.horz_stabiliser.span         = vars(10);
    plane.misc_properties.aspect_ratio = vars(11);
end