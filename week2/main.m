%M4 - Team X
%This script execute all the tasks of the second week of the project
clear all;

%CONFIG PARAMETERS
param.gaussianColor = false;
%Value between [-2.5,2.5]
param.alpha = 0.1
%Gaussian Modelling
%------------------

%Get the Datasets
datasets = dir('Dataset/');
datasets = datasets(find(vertcat(datasets.isdir)));
datasets = datasets(3:end);

for i=1:length(datasets)
    
    %Training 
    %---------
    %List the images for training
    inputFolder = strcat('Dataset/',datasets(i).name,'/input/')
    dirList = dir(inputFolder);
    %Remove the . .. from the list
    dirList = dirList(3:end);
    %Use the half of the Dataset to train
    numberTraining = floor(length(dirList) / 2);
    [mean_dataset{i} sd_dataset{i}] = gaussian_training(inputFolder,dirList,numberTraining,param.gaussianColor);
    
    %Testing
    %-------
    for ii=numberTraining+1:length(dirList)
        
        if(param.gaussianColor)
            cumsum_image = cumsum_image + imread(strcat(inputFolder,dirList(ii).name));
        else
            current_image = rgb2gray(imread(strcat(inputFolder,dirList(ii).name)));
            out{i,ii} = abs(current_image-mean_dataset{i}) >= (param.alpha*(sd_dataset{i}+2));
            imwrite(out{i,ii},strcat('Dataset/',datasets(i).name,'/results/',int2str(ii),'.png'));
        end
    end;
    
    
end


    