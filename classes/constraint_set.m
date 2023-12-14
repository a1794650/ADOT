%Name:     Isaac Nakone
%Date:     11/12/2023
%Purpose:  This is a class to be used to store the 
%          ADOT constraints.

classdef constraint_set

    properties


        %This needs to be updated whenever a new function 
        % con_<CODE NAME FOR CONSTRAINT> is added.
        names = ["BC";
                 "MP"
                 "SM2";
                 "SM3";
                 "WP";
                 "FW";
                 "PW";
                 "AR" ];

        %This description needs to be updated whenever a new function 
        % con_<CODE NAME FOR CONSTRAINT> is added.

        descriptions = ["Battery Capacity versus cruise required (BC)";
                        "Motor power verus required for takeoff (MP)"
                        "Static margin for mission 2 versus required (SM2)"
                        "Static margin for mission 3 versus required (SM3)";
                        "Wing position versus required (WP)";
                        "Check that dolls fit in fuselage width direction (FW)";
                        "Number of passengers exceeds number in width direction (PW)";
                        "Aspect ratio of wing versus required apsect ratio of wing (AR)"];

    end

    methods

        %This code here automatically takes the names and calls the
        %nonlcons. Note eqcon = [] because there are no equality
        %constraints.
        function [nonlcon,eqcon] = eval_constraints(obj,vars, plane) 
            N_constraints = size(obj.names,1);

            vars2aircraft(vars,plane);

            calcs(plane); %everytime this function is called, the plane must be updated!
            nonlcon = [];



         
            for i = 1:N_constraints
                
                str = strcat(['con_',convertStringsToChars(obj.names(i)), '(plane);']); 
                nonlcon = [nonlcon; eval(str);];
            end

            nonlcon = -nonlcon; %This needs to be negative for the algorithm to work.
            eqcon = [];
        end

    end


end