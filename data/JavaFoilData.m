function aerofoil_data = JavaFoilData(type)
    min_angle = 8;                                                              %Set minimum angle ofr C_L_max
    if(type == 'wing')
        %If the wing aerofils are required, get data from all wing aerofoils
        excelFileName(1) = "./data/EPPLER 398";
        excelFileName(2) = "./data/GOE 567";
        excelFileName(3) = "./data/NACA 2112";
    else
        %If tail aerofils are required, get data from all tail aerofoils
        excelFileName(1) = "./data/NACA 0009";
    end

     
    
    num_aerofoils = 1;                                                          %Initialise current number of aerofils processed
    for i=1:length(excelFileName)
        %finding CL/alpha slope
        initTable = readtable(excelFileName(i), 'Sheet', 1);                    %Look at data at 0 flap size
        t_length = size(initTable.Cl);                                          %Find number of C_L values in database
        t_length = t_length(1);
        C_L_0 = initTable.Cl(31);                                               %Find initial C_L at 0 angle of attack and 0 flap deflection
        CL_max = max(initTable.Cl);                                             %Find max of table with 0 flap size to find C_L_alpha slope
        slope = (CL_max - C_L_0)/(t_length/2);                                  %Find C_L_alpha slope
    
        %finding CD/alpha data
        C_D_data = initTable.Cd;                                                %Read in the data for the coefficients of drag
        alpha = initTable.x_;
        %find max for 4 different flap sizes
        [~, sheetNames] = xlsfinfo(excelFileName(i));
        for j=2:4
            currentTable = readtable(excelFileName(i), 'Sheet', j);             %Read in Each Flap deflection angle data for a given flap size
            aerofoil.CL_a = slope;                                              %Set aerfoil C_L_alpha
            aerofoil.C_L_0 = C_L_0;                                             %Set C_L value at 0 angle of attack
            aerofoil.C_L_max = max(max(max(currentTable.Cl(min_angle + 30 : 60),... %Find C_L_max
                currentTable.Cl_1(min_angle + 30 : 60)), ...
                currentTable.Cl_2(min_angle + 30 : 60)));
            aerofoil.C_D_data = table(C_D_data, alpha);                                       %Add C_D data to aerfoil struct to be able to calculate the C_D
            aerofoil.flap_size = sheetNames(j);
            aerofoil_data(num_aerofoils) = aerofoil;                            %Add aerofoil to aerofoil table
            num_aerofoils = num_aerofoils+1;                                    %Incremenet number of aerfoils in table
        end 
    end

    
   


    aerofoil_data(1).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','C2:D74');    %(1) EPPLER 398
    aerofoil_data(2).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','C2:D74');    %(1) EPPLER 398
    aerofoil_data(3).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','C2:D74');    %(1) EPPLER 398


    aerofoil_data(4).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','E2:F34');    %(2) GOE 567
    aerofoil_data(5).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','E2:F34');    %(2) GOE 567
    aerofoil_data(6).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','E2:F34');    %(2) GOE 567

    aerofoil_data(7).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','A2:B81');    %(3) NACA 2112
    aerofoil_data(8).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','A2:B81');    %(3) NACA 2112
    aerofoil_data(9).coords = readtable("data/Aerofoil Coordinates.xlsx",'Sheet',1,'Range','A2:B81');    %(3) NACA 2112

    aerofoil_data(1).bottom = min(aerofoil_data(1).coords(:,2).Var2);
    aerofoil_data(2).bottom = min(aerofoil_data(1).coords(:,2).Var2);
    aerofoil_data(3).bottom = min(aerofoil_data(1).coords(:,2).Var2);
    aerofoil_data(1).top    = max(aerofoil_data(1).coords(:,2).Var2);
    aerofoil_data(2).top    = max(aerofoil_data(1).coords(:,2).Var2);
    aerofoil_data(3).top    = max(aerofoil_data(1).coords(:,2).Var2);
    
    aerofoil_data(1).th     =  aerofoil_data(1).top -aerofoil_data(1).bottom;
    aerofoil_data(2).th     =  aerofoil_data(1).th;
    aerofoil_data(3).th     =  aerofoil_data(1).th;

    aerofoil_data(4).bottom = min(aerofoil_data(4).coords(:,2).Var2);
    aerofoil_data(5).bottom = min(aerofoil_data(4).coords(:,2).Var2);
    aerofoil_data(6).bottom = min(aerofoil_data(4).coords(:,2).Var2);
    aerofoil_data(4).top    = max(aerofoil_data(4).coords(:,2).Var2);
    aerofoil_data(5).top    = max(aerofoil_data(4).coords(:,2).Var2);
    aerofoil_data(6).top    = max(aerofoil_data(4).coords(:,2).Var2);

    aerofoil_data(4).th     =  aerofoil_data(4).top -aerofoil_data(4).bottom;
    aerofoil_data(5).th     =  aerofoil_data(4).th;
    aerofoil_data(6).th     =  aerofoil_data(4).th;


    aerofoil_data(7).bottom = min(aerofoil_data(7).coords(:,2).Var2);
    aerofoil_data(8).bottom = min(aerofoil_data(7).coords(:,2).Var2);
    aerofoil_data(9).bottom = min(aerofoil_data(7).coords(:,2).Var2);
    aerofoil_data(7).top    = max(aerofoil_data(7).coords(:,2).Var2);
    aerofoil_data(8).top    = max(aerofoil_data(7).coords(:,2).Var2);
    aerofoil_data(9).top    = max(aerofoil_data(7).coords(:,2).Var2);

    aerofoil_data(7).th     =  aerofoil_data(7).top -aerofoil_data(7).bottom;
    aerofoil_data(8).th     =  aerofoil_data(7).th;
    aerofoil_data(9).th     =  aerofoil_data(7).th;


end