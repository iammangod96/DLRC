clear;
clc;    
topLevelFolder = 'G:\BITS\3-2\ML\lfw2';
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
	thisFolder = listOfFolderNames{k}
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
	if numberOfImageFiles < 20
        for f = 1 : numberOfImageFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            delete(fullFileName);
        end
        
    else
        for f = 1 : numberOfImageFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            I = imread(fullFileName);
            I = imcrop(I,[86 80 78 90]);
            imwrite(I,fullFileName);
			fprintf('     Processing image file %s\n', fullFileName);
        end
        movefile(thisFolder,'G:\BITS\3-2\ML\new');
    end
end

