%Name:    Isaac Nakone
%Date:    11/12/2023
%Purpose: This is a class definition for an
%         aircraft to be used in the ADOT code.

classdef aircraft < handle &...  %Inherits handle properties.
        matlab.mixin.SetGet &... %Inherits setters and getters.
        matlab.mixin.Copyable    %Is copyable.
    properties 
        static_margin2 = NaN;
        static_margin3 = NaN;

        static_margin_min_req = 0.05;
        static_margin_max_req = 0.1;

        num_power_vals = 5;

        COG2 = NaN;
        COG3 = NaN;

        mass2 = NaN;
        mass3 = NaN;

        mass = NaN;

        aerodynamic_center2 = NaN;

        aerodynamic_center3 = NaN;

        units = struct('in2mm', 0.0254, 'g2kg', 1e-3, 'mm2m', 1e-3,...
                       'h2s', 3600, 'min2s', 60, 'W2mW', 1e3, 'min2h', 0.0167,...
                       'kg2lb', 2.2046, 'W2hp', 0.0013, 'm2ft', 3.2808, 'ft2m', 0.3048);

        course = struct('length', 610, 'takeoff_distance' ,20);

        score = struct('M1', 1.0, 'M2', NaN, 'M3', NaN, 'baseline2',0.01,'baseline3',0.005,...
                        'total', NaN);

        passengers = struct('total', NaN, 'nwidth',NaN, 'length',NaN,...
                            'doll_length', 0.1397, 'doll_width', 0.0428, 'doll_mass',0.015,...
                            'mass',NaN);
        
        fuselage = struct('width',NaN, 'length', NaN, 'height', NaN,...
                           'form_factor',NaN,'mass',NaN, 'density', 0.1, ...
                           'wall_thickness',0.005, 'tray_thickness',0.005,...
                            'object_spacing',0.005,...
                            'interference_factor', 1.0, ...
                            'min_width2',NaN, 'min_width3', NaN, 'reynolds_num', NaN);

        wing = struct('chord_root',NaN, 'chord_tip',...
                       NaN, 'span', NaN, 'position',NaN, ...
                       'coeff_lift_max', NaN, 'taper_ratio', NaN,...
                       'area_density',0.1,'mass',NaN, 'sweep_angle25', 0,...
                       'interference_factor', 1.1, 'chord_thickness', NaN,...
                       'aerodynamic_center2',NaN,...
                       'aerodynamic_center3',NaN,...
                       'aspect_ratio', NaN, ...
                       'coeff_drag_data', zeros(1,2), ...
                       'coeff_lift0',NaN, ...
                       'coeff_liftA',NaN, ...
                       'wetted_area', NaN, ...
                       'aspect_ratio_max', 18,...
                       'aspect_ratio_min', 3);


        horz_stabiliser = struct('chord_root',NaN, 'chord_tip', ...
                                 NaN, 'span',NaN, ...
                                 'interference_factor', 1.04, ...
                                 'mass', NaN, 'area_density', 0.1);
        vert_stabiliser = struct('chord_root',NaN, 'chord_tip', ...
                                 NaN, 'span',NaN, ...
                                 'interference_factor', 1.04,...
                                 'angle', 60, 'mass', NaN, 'area_density', 0.1);

        tail = struct('angle',60);

        cruise_properties = struct('speed',NaN, 'power', NaN, 'capacity', NaN, 'laps3', ...
                                    NaN, 'time2', NaN, 'coeff_lift', NaN);

        turning_properties = struct('speed2',NaN, 'speed3' ,NaN, 'power', NaN, 'capacity', NaN, 'laps3', NaN, 'coeff_lift', NaN);

        misc_properties = struct('static_margin2', NaN, 'static_margin3',NaN, ...
                                 'load_factor',5, 'aspect_ratio',NaN, ...
                                 'time_safety', 1.0, ...
                                 'propellor_efficiency',0.75,...
                                 'electrical_efficiency',0.95,...
                                 'propulsive_efficiency',0.75*0.95, ...
                                 'density_PETG', 1230.0);

        battery = struct('capacity', NaN, 'voltage', NaN, 'mass',NaN,...
                         'height', NaN, 'length', NaN);

        motor = struct('number', NaN, 'power_max', NaN, 'mass', NaN);

        payload = struct('mass2',NaN, 'mass3',NaN);

        crew = struct('mass',0.035,'doll_length', 0.1397);

        emt = struct('mass',0.035);

        msc = struct('mass', NaN, 'density', 8390);

        nose = struct('length', NaN, 'angle', 45);

        servos = struct('mass', 0.012, 'number', 8);

        guerney = struct('mass', 0.001);

        medical_bay = struct('length', NaN);

        patient = struct('mass', 0.001); %Change this a sI'm not sure of patient mass.

        cabin = struct('length', NaN);

        landing_gear = struct('mass', 0.1,'wheel_width',0.025,...
            'wheel_height', 0.080, 'strut_thickness1', 0.003, ...
            'strut_thickness2', 0.001);

        electronics = struct('mass', 0.1);

        trays = struct('thickness', 0.005, 'mass', NaN);

        physics = struct('air_density0',1.225, ...
            'air_density30',1.775, 'gravity',9.81, ...
            'kinematic_viscosity', 0.00001798,...
            'gas_constant', 287, 'thermodynamic_ratio', 1.4,...
            'temperature', 12.224 + 273.15);
    end

    methods 


    end


end