%Name:        Isaac Nakone, Denis Vasilyev, Harry Rowton, Jingya Liu
%Date:        15/12/2023
%Description: Master code for the ADOT calls all the sub-functions. When
%             completed this will both generate valid designs and optimise 
%             those designs.




clear;
clc;
close;



load('ranges.mat');

rng(0);

%Add subdirectories:
addpath('./misc_funs');
addpath('./data');
addpath('./con_funs');
addpath('./classes');

%Add sub-subdirectories:
addpath('./misc_funs/scoring');
addpath('./misc_funs/mass_funs');
addpath('./misc_funs/dimensions');
addpath('./misc_funs/cruise');
addpath('./misc_funs/center_of_gravity');
addpath('./misc_funs/drag');



%Suppresses warning from readtable:
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames'); 

constants = constant_table;

%load in the battery table:
batterySpecs = readtable("BatterySpecs.xlsx");


%load in the motor table:
motorSpecs = readtable("MotorSpecs.xlsx");

%load in the airfoil tables:
wingSpecs = JavaFoilData('wing');
tailSpecs = JavaFoilData('tail');


count = 0;

N_valid = 10;

N_iters = 1;


constraints = constraint_set;

N = 0;

options=optimoptions(@fmincon,'Display','off');


while (count < N_valid)
    tic
    % disp(N);

    N = N + 1;

    plane = aircraft;
 

    %Choose the battery, motor, wing, and tail randomly:
    battery_index = 38;
    motor_index   = 6;
    wing_index    = 5;
    horz_index    = 1;
    vert_index    = horz_index;


    %Link the constants to the aircraft:
    plane.link_constants(constants)

    %Link the battery to the aircraft:
    plane.link_battery( battery_index, batterySpecs);

    %Link the motor to the aircraft:
    plane.link_motor( motor_index, motorSpecs);

    %Link the airfoils to the aircraft:
    plane.link_airfoils(wingSpecs, tailSpecs,... 
                        wing_index, horz_index, vert_index);

    
    %generate some random params on interval [0,1]:
    opt_vars0 = (ranges(:,2)-ranges(:,1)).*rand(size(ranges,1),1) + ranges(:,1);

    opt_vars0(10) = min(opt_vars0(10), 2.5*0.3048); % restricting empennage based off concept design (folding wing).
    stab_vars = 0.55;

    % opt_vars = fminimax(@(opt_vars)constraints.eval_constraints(opt_vars,stab_vars, plane),...
    %                   opt_vars0,[],[],[],[],ranges(:,1),ranges(:,2), [],options);


    for i = 1:N_iters
        opt_vars = fmincon(@(opt_vars)0,opt_vars0,[],[],[],[],ranges(:,1),ranges(:,2),...
            @(opt_vars)constraints.eval_constraints(opt_vars,stab_vars, plane),options);
    
        [nonlcon,eqcon] = constraints.eval_constraints(opt_vars,stab_vars, plane);
    
        
    
        if (sum(nonlcon > 0) == 0) %This means plane has satisfied constraints
            
    
            count = count + 1;
    
            valid(count) = plane;
    
            disp(count);
            toc
            break;
            
        else
            opt_vars0 = opt_vars;

        end

    end

    
   
end







