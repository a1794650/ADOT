%Name:    Denis Vasilyev
%Date:    19/12/2023
%Purpose: This reads in the databases of optimised designs, plots them over
%number of seeds and finds which one the optimal one is

function best_design = Post_Processing()
clear;
clc;
% Specify the folder path
folder_path = './test';

% Get a list of all Excel files in the folder
files = dir(fullfile(folder_path, '*.xlsx'));

%Define array in which the scores are stored in as they increase
Best_Scores = [0];
% Loop through each Excel file and read it into a table
for i = 1:length(files)
    % Get the current file name
    file_name = files(i).name;
    
    % Construct the full file path
    file_path = fullfile(folder_path, file_name);
    
    % Read the current Excel file into a table
    data_table = readtable(file_path);
    for j=1:length(data_table.score)
        if (data_table.score(j)>Best_Scores(end))
            Best_Scores = [Best_Scores, data_table.score(j)];
            best_design.file_index = i;
            best_design.index = j;
        else
            Best_Scores = [Best_Scores, Best_Scores(end)];
        end
    end
    
end

plot(Best_Scores);

end