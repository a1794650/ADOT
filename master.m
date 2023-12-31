%Name:        Isaac Nakone, Denis Vasilyev, Harry Rowton, Jingya Liu
%Date:        15/12/2023
%Description: Master code for the ADOT calls all the sub-functions. When
%             completed this will both generate valid designs and optimise 
%             those designs.


% 
% obj.passengers.nwidth            = opt_vars(1);  
% obj.passengers.total             = opt_vars(2);
% obj.msc.mass                     = opt_vars(3);
% obj.wing.taper_ratio             = opt_vars(4);
% obj.wing.chord_root              = opt_vars(5);
% obj.fuselage.width               = opt_vars(6);
% obj.wing.span                    = opt_vars(7);
% obj.wing.position                = opt_vars(8);
% obj.horz_stabiliser.chord_root   = opt_vars(9);
% obj.horz_stabiliser.span         = opt_vars(10);
% obj.misc_properties.aspect_ratio = opt_vars(11);


clear;
clc;
close;



load('ranges.mat');

rng(0);
rng(1);



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

N_valid = 2000;

N_iters = 1;


constraints = constraint_set;

N = 0;

options1=optimoptions(@fmincon,'Display','off', 'ConstraintTolerance', 0);
%options=optimoptions(@fminimax,'Display','off');
tic
while (count < N_valid)
    % disp(N);

    N = N + 1;

    plane = aircraft;
 

    %Choose the battery, motor, wing, and tail randomly:
    battery_index = randi([4 26],1);
    motor_index   = randi([6 6],1);
    wing_index    = randi([1 15],1);
    horz_index    = randi([1 6],1);
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

    

   % [nonlcon,eqcon] = constraints.eval_constraints(opt_vars0,stab_vars, plane);

   if (1)


       % valid(count) = plane; 

       [opt_vars1,S, exitflag] = fmincon(@(opt_vars)(-1)*score(plane, opt_vars,stab_vars ),opt_vars0,[],[],[],[],ranges(:,1),ranges(:,2),...
                    @(opt_vars)constraints.eval_constraints(opt_vars,stab_vars, plane),options1);

       plane.link_opt_vars(opt_vars1);

       plane.score.total = S;
       if(exitflag == 1)
           toc
            tic
            count = count + 1;
            valid(count) = plane; 
            disp(count);
       end

   end
 
   
end


%use this to look at specific   vlaues in all designs for debugging
for i = 1:10
    disp(valid(i).score.total);
end
filename = "optimised_designs.mat";
save(filename,"valid")

disp("done");





% function [nonlcon_weighted, eqcon] = weighted_constraints(opt_vars,stab_vars, plane, weights, constraints)
%     [nonlcon,eqcon] = constraints.eval_constraints(opt_vars,stab_vars, plane);
% 
%     nonlcon_weighted = weights.*nonlcon;
% 
% 
% end



