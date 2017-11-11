clear;
clc;    
topLevelFolder = 'G:\BITS\3-2\ML\partition\test';
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)

% Process all image files in those folders.
for k = 1 : numberOfFolders
	% Get this folder and print it out.
	thisFolder = listOfFolderNames{k};
	fprintf('Processing folder %s\n', thisFolder);
	
	% Get PNG files.
	filePattern = sprintf('%s/*.png', thisFolder);
	baseFileNames = dir(filePattern);
	% Add on TIF files.
	filePattern = sprintf('%s/*.tif', thisFolder);
	baseFileNames = [baseFileNames; dir(filePattern)];
	% Add on JPG files.
	filePattern = sprintf('%s/*.jpg', thisFolder);
	baseFileNames = [baseFileNames; dir(filePattern)];
	numberOfImageFiles = length(baseFileNames);
	% Now we have a list of all files in this folder.
    i=0;
	    for f = 1 :numberOfImageFiles
            fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            fprintf('     Processing image file %s\n', fullFileName);
            
            i = i + 1;
            if(i<(numberOfImageFiles-9))
                delete(fullFileName);
            end
        end
        if numberOfImageFiles > 2
            movefile(thisFolder,'G:\BITS\3-2\ML\newtest');
        end
    
end

