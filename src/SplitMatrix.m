function SplitMatrix(filename, matrixname)
%SPLITMATRIX Split the given matrix into column vectors. The matrix is
%contained in a mat file identified by the given filename.
%
% INPUT:
%           filename - String representing the file to load.
%
%           matrixname - String representing the matrix to be split.
%               The file contains data in a m-by-n matrix form. The function
%               will split into n files containing m-by-1 data vectors, one
%               for each column in the matrix.
%
%
% Copyright (C) 2014 Francesco Giovannini
% Author: Francesco Giovannini <joernano@gmail.com>
% Permission is granted to copy, distribute, and/or modify this program under the terms of 
% the GNU General Public License, version 2 or any later version published by the Free Software Foundation.
%
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
% the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
% Public License for more details
%

%% Load file
% Add .mat suffix if not present
if numel(filename > 0)
    if numel(filename) < 4 || ~strcmp(filename(end-3:end),'.mat')
        filename = [filename, '.mat'];
    end
end
filepath = which(filename);
% Check file existence
if ~exist(filepath, 'file')
    tmpMsg = ['Could not find the given data file [', filename, '].'];
    if ~isempty(filepath)
        tmpMsg = [tmpMsg, '\n', 'Path requested was: ', filepath];
    end
    error('WaveChannels:FileNotFound', tmpMsg);
end
% Check variable existence
w = who('-file', filepath);
if (sum(strcmp(matrixname, w)) == 0)
    error('WaveChannels:VariableNotFound', ['Could not find the \"', matrixname, '\" data matrix in the given data file [', filename, '].', ...
        '\n', 'Loaded file is at: ', filepath]);
end

% Load it
fprintf(['Loading data from: ', filepath, '. \n']);
load(filepath);
fprintf('Done. \n');


%% Create output directory
% Create the folder if it doesn't exist already.
dirname = 'data';
if ~exist(dirname, 'dir')
  mkdir(dirname);
end


%% Get matrix to split
% Generate variable name
data = eval(matrixname);
eval(['clear ', matrixname]);


%% Split wave into channels
fprintf('Splitting file into channels. \n');
tic;
for i = 1:size(data, 2)
    % Get channel data
    channel = data(:, i);
    % Save data
    save(['dataa/channel', num2str(i), '.mat'], 'channel');
end
toc;
fprintf('Done. \n');


end
