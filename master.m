
clear;
clc;
close;

%Inputs:
%       (1)  n_pw    == number of passengers in the width direction.
%       (2)  N_pass  == total number of passengers.
%       (3)  W_MSC   == weight of the medical supply cabinet.
%       (4)  TR_w    == taper ratio of the wing.
%       (5)  C_w_r   == chord of the main wing at the root.
%       (6)  F_w     == fuselage width.
%       (7)  b_w     == wing span.
%       (8)  X_w     == the position of the wing.
%       (9)  C_t     == the chord of the tail.
%       (10) b_t     == the span of the tail.
%       (11) AR      == the aspect ratio.

ranges = [1,2;     %n_pw
          2,4;    %N_pass
          0.1, 0.15;   %W_MSC
          0.8, 1.0; %TR_w
          0.2, 0.4; %C_w_r
          0.1, 0.5; %F_w
          0.8, 1.5; %b_w
          0.2, 0.3;%X_w
          0.06, 0.2; %C_t
          0.8, 1.3; %b_t
          0.65, 1.3]; %AR          

rng("shuffle");

%Add subdirectories:
addpath('./misc_funs');
addpath('./data');
addpath('./con_funs');
addpath('./classes');

%Add sub-subdirectories:
addpath('./misc_funs/wrappers');
addpath('./misc_funs/scoring');
addpath('./misc_funs/mass_funs');
addpath('./misc_funs/dimensions');
addpath('./misc_funs/cruise');
addpath('./misc_funs/center_of_gravity');
addpath('./misc_funs/linkers');
addpath('./misc_funs/drag');



%Suppresses warning from readtable:
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames'); 

%load in the battery table:
batterySpecs = readtable("BatterySpecs.xlsx");


%load in the motor table:
motorSpecs = readtable("MotorSpecs.xlsx");
wingSpecs = JavaFoilData('wing');
tailSpecs = JavaFoilData('tail');

count = 0;

N_valid = 10;


constraints = constraint_set;

N = 0;

tic
while (count < N_valid)

    % disp(N);

    N = N + 1;

    plane = aircraft;
 

    %Choose the battery, motor, wing, and tail randomly:
    battery_index = randi(size(batterySpecs,1));
    motor_index   = randi(size(motorSpecs,1));
    wing_index    = randi(size(wingSpecs,1));
    horz_index    = randi(3);
    vert_index    = horz_index;

    %Link the battery to the aircraft:
    battery2aircraft(plane, battery_index, batterySpecs);

    %Link the motor to the aircraft:
    motor2aircraft(plane, motor_index, motorSpecs);


    %Link the airfoils to the aircraft:
    airfoils2aircraft(plane,wingSpecs, tailSpecs,... 
                        wing_index, horz_index, vert_index);

    
    %generate some random params on interval [0,1]:
    xn = rand(size(ranges,1),1);

    vars = (ranges(:,2)-ranges(:,1)).*xn + ranges(:,1);

    vars(11) = min(vars(9), 2.5*0.3048); % restricting empennage based off concept design (folding wing).


    [nonlcon,eqcon] = constraints.eval_constraints(vars, plane);

    

    if (sum(nonlcon > 0) == 0) %This means plane has satisfied constraints
        toc

        count = count + 1;

        valid(count) = plane;

        disp(count);
        tic
    end

    
   
end







