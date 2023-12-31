%Name:    Denis Vasilyev
%Date:    19/12/2023
%Purpose: This reads in the databases of optimised designs, plots them over
%number of seeds and finds which one the optimal one is

function best_design = Post_Processing()
clear;
clc;

addpath('./aircrafts');

% Specify the folder path
folder_path = './aircrafts';

% Get a list of all Excel files in the folder
files = dir(fullfile(folder_path, '*.mat'));

%Define array in which the scores are stored in as they increase
Best_Scores = [];
% Loop through each Excel file and read it into a table
for i = 1:length(files)
    % Get the current file name
    file_name = files(i).name;
    
    % Construct the full file path
    file_path = fullfile(folder_path, file_name);
    
    % Read the current Excel file into a table
    data_table = load(file_path);
    for j=1:length(data_table.valid)
        data_table.valid(j).score.total = -data_table.valid(j).score.total;
        if(size(Best_Scores) == 0)
            Best_Scores = [Best_Scores, data_table.valid(j).score.total];
            best_design = data_table.valid(j);
        elseif (data_table.valid(j).score.total>Best_Scores(end))
            Best_Scores = [Best_Scores, data_table.valid(j).score.total];
            best_design = data_table.valid(j);
        else
            Best_Scores = [Best_Scores, Best_Scores(end)];
        end
    end
    %clear("valid");
end

plot(Best_Scores);

end