clear;
clc;    
topLevelFolder = 'G:\BITS\3-2\ML\partitioned\newtrain';
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

X_features = [];
Y_categories = [];



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
    
	    for f = 1 :numberOfImageFiles
            fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            I = imread(fullFileName);
            X_features = [X_features ; reshape(I,[1 7189])];
            Y_categories = [Y_categories; k];
            fprintf('     Processing image file %s\n', fullFileName);
        end
    
end
%X_features
%Y_categories
X_feat = double(X_features);
Y_cat = typecast(Y_categories,'double');


topLevelFolder = 'G:\BITS\3-2\ML\partitioned\newtest';
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

X_test_features = [];
Y_test_real_categories = [];

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
   

	    for f = 1 :numberOfImageFiles
            fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            I = imread(fullFileName);
            X_test_features = [X_test_features ; reshape(I,[1 7189])];
            Y_test_real_categories = [Y_test_real_categories; k];
            %fprintf('     Processing image file %s\n', fullFileName);
        end
   
end

X_test_feat = double(X_test_features);
Y_test_real_cat = typecast(Y_test_real_categories,'double');


% X_features
% Y_categories
% X_feat
% Y_cat

% X_test_features
% Y_test_real_categories
% X_test_feat
% Y_test_real_cat
correct=0;
total=62;
for i_test = 1:total
   fprintf('Testing image class %d\n', i_test);
   d_min=99999999;
   ans_class = -1;
   Y = [];
   for i_test1 = (i_test*10)-9:i_test*10
      Y = [Y, normc(reshape( X_test_feat(i_test1,:),7189,1 ))];  
   end
   for i_xi = 1:62
      Xi = [];
      for i1 = (i_xi*10)-9:i_xi*10
         Xi = [Xi, normc(reshape( X_feat(i1,:),7189,1 ))]; 
      end
         
%calculation of d
      
        %Xi_cap formation
        Xi_cap = Xi;
        for i1 = 1:10
            Xi_cap(:,i1) = Xi_cap(:,i1) - Xi_cap(:,10); 
        end
        Xi_cap(:,10) = [];
      
        %Y_cap formation
        Y_cap = Y;
        for i1 = 1:10
            Y_cap(:,i1) = Y_cap(:,i1) - Y_cap(:,10); 
        end
        Y_cap(:,10) = [];
        
        %Si_formation
        Si = [Xi_cap, -Y_cap];
        si = Y(:,10) - Xi(:,10);
        
        %Bi formation
        Bi = ( transpose(Si)*Si )\(transpose(Si)*si);
        
        %r1 formation
        r1 = Xi_cap*( Bi(1:9,:) ) + Xi(:,10);
        r2 = Y_cap*( Bi(10:18,:) ) + Y(:,10);
        
        %distance
        d = norm((r1-r2),1);
        if(d<d_min)
            d_min = d;
            ans_class = i_xi;
        end
%end of calculation of d
   end
   if(ans_class == Y_cat((i_test*10)-9)-1)
       correct = correct+1;
   end
end

fprintf('\n\n Correct = %d',correct);
fprintf('\nTotal = %d',total);
fprintf('\nAccuracy = %d%%\n',correct*100/total);