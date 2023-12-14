%Name:        Isaac Nakone, Denis Vasilyev, Harry Rowton, Jingya Liu
%Date:        15/12/2023
%Description: This is a class definition for an
%             aircraft to be used in the ADOT code.
%             Note that unknown variables are set to
%             NaN to begin with to ensure that we are
%             not using unspecified values in the maths.

classdef aircraft < handle &...  %Inherits handle properties.
        matlab.mixin.SetGet &... %Inherits setters and getters.
        matlab.mixin.Copyable    %Is copyable.
    properties 

        %Variables related to the whole plane:
        static_margin2 = NaN;
        static_margin3 = NaN;

        static_margin_min_req = 0.05;
        static_margin_max_req = 0.1;

        num_power_vals = 10;

        COG2 = NaN;
        COG3 = NaN;

        mass2 = NaN;
        mass3 = NaN;

        mass = NaN;

        aerodynamic_center2 = NaN;
        aerodynamic_center3 = NaN;


        %Unit conversions:
        units = struct('in2mm', 0.0254, 'g2kg', 1e-3, 'mm2m', 1e-3,...
                       'h2s', 3600, 'min2s', 60, 'W2mW', 1e3, 'min2h', 0.0167,...
                       'kg2lb', 2.2046, 'W2hp', 0.0013, 'm2ft', 3.2808, 'ft2m', 0.3048);

        %Physical parameters:
        physics = struct('air_density0',1.225, ...
            'air_density30',1.775, 'gravity',9.81, ...
            'kinematic_viscosity', 0.00001798,...
            'gas_constant', 287, 'thermodynamic_ratio', 1.4,...
            'temperature', 12.224 + 273.15);


        %Size of the course that we will fly through.
        course = struct('length', 610, 'takeoff_distance' ,20);

        score = struct('M1', 1.0, 'M2', NaN, 'M3', NaN, 'baseline2',0.01,'baseline3',0.005,...
                        'total', NaN);

        passengers = struct('total', NaN, 'nwidth',NaN, 'length',NaN,...
                            'doll_length', 0.1397, 'doll_width', 0.0428, 'doll_mass',0.015,...
                            'mass',NaN);
        
        fuselage = struct('width',NaN, 'length', NaN, 'height', NaN,...
                           'form_factor',NaN,'mass',NaN, 'density', 1230, ...
                           'wall_thickness',0.0008, 'tray_thickness',0.005,...
                            'object_spacing',0.01,...
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

        
    end

    methods 

        function link_opt_vars(obj, vars)
            obj.passengers.nwidth            = vars(1);  
            obj.passengers.total             = vars(2);
            obj.msc.mass                     = vars(3);
            obj.wing.taper_ratio             = vars(4);
            obj.wing.chord_root              = vars(5);
            obj.fuselage.width               = vars(6);
            obj.wing.span                    = vars(7);
            obj.wing.position                = vars(8);
            obj.horz_stabiliser.chord_root   = vars(9);
            obj.horz_stabiliser.span         = vars(10);
            obj.misc_properties.aspect_ratio = vars(11);
        end

        function link_battery(obj, battery_index, batterySpecs)
            obj.battery.capacity = batterySpecs.batteryCapacity_mAh_(battery_index);
            obj.battery.width    = batterySpecs.Bw_mm_(battery_index)*obj.units.mm2m;
            obj.battery.height   = batterySpecs.Bh(battery_index)*obj.units.mm2m;
            obj.battery.length   = batterySpecs.Bl(battery_index)*obj.units.mm2m;
            obj.battery.mass     = batterySpecs.weight_g_(battery_index)*obj.units.g2kg;
            obj.battery.voltage  = 22.2; %change this???
        end

        function link_motor(obj, motor_index, motorSpecs)
            obj.motor.power_max = motorSpecs.BatteryPower_W_(motor_index);
            obj.motor.mass = motorSpecs.weight_g_(motor_index)*obj.units.g2kg;
            obj.motor.number = 2;

        end

        function link_airfoils(obj,wingSpecs, tailSpecs,... 
            wing_index, horz_index, vert_index)
            obj.wing.coeff_liftA = wingSpecs(wing_index).CL_a;
            obj.wing.coeff_lift0 = wingSpecs(wing_index).C_L_0;
            obj.wing.coeff_lift_max = wingSpecs(wing_index).C_L_max;
            obj.wing.coeff_drag_data = table2array(wingSpecs(wing_index).C_D_data);
            obj.wing.thickness = wingSpecs(wing_index).th;
        
            obj.horz_stabiliser.coeff_liftA = tailSpecs(horz_index).CL_a;
            obj.horz_stabiliser.coeff_lift0 = tailSpecs(horz_index).C_L_0;
            obj.horz_stabiliser.coeff_lift_max = tailSpecs(horz_index).C_L_max;
            obj.horz_stabiliser.coeff_drag_data = table2array(tailSpecs(horz_index).C_D_data);
            obj.horz_stabiliser.thickness = wingSpecs(horz_index).th;
        
            obj.vert_stabiliser.coeff_liftA = tailSpecs(vert_index).CL_a;
            obj.vert_stabiliser.coeff_lift0 = tailSpecs(vert_index).C_L_0;
            obj.vert_stabiliser.coeff_lift_max = tailSpecs(vert_index).C_L_max;
            obj.vert_stabiliser.coeff_drag_data = table2array(tailSpecs(vert_index).C_D_data);
            obj.vert_stabiliser.thickness = wingSpecs(vert_index).th;
        end


    end


end