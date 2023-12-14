

function airfoils2aircraft(plane,wingSpecs, tailSpecs,... 
    wing_index, horz_index, vert_index)
    plane.wing.coeff_liftA = wingSpecs(wing_index).CL_a;
    plane.wing.coeff_lift0 = wingSpecs(wing_index).C_L_0;
    plane.wing.coeff_lift_max = wingSpecs(wing_index).C_L_max;
    plane.wing.coeff_drag_data = table2array(wingSpecs(wing_index).C_D_data);
    plane.wing.thickness = wingSpecs(wing_index).th;

    plane.horz_stabiliser.coeff_liftA = tailSpecs(horz_index).CL_a;
    plane.horz_stabiliser.coeff_lift0 = tailSpecs(horz_index).C_L_0;
    plane.horz_stabiliser.coeff_lift_max = tailSpecs(horz_index).C_L_max;
    plane.horz_stabiliser.coeff_drag_data = table2array(tailSpecs(horz_index).C_D_data);
    plane.horz_stabiliser.thickness = wingSpecs(horz_index).th;

    plane.vert_stabiliser.coeff_liftA = tailSpecs(vert_index).CL_a;
    plane.vert_stabiliser.coeff_lift0 = tailSpecs(vert_index).C_L_0;
    plane.vert_stabiliser.coeff_lift_max = tailSpecs(vert_index).C_L_max;
    plane.vert_stabiliser.coeff_drag_data = table2array(tailSpecs(vert_index).C_D_data);
    plane.vert_stabiliser.thickness = wingSpecs(vert_index).th;


end