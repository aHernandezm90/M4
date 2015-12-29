function [ mean_dataset, sd_dataset ] = GaussianTraining( inputFolder,dirlist,numberTraining,gaussianColor)
%Train for the Non-recursive Gaussian modeling for background substraction
%The function compute the mean and standard deviation of a set of images 
    
    %Load the images and compute the sum of the images
    %Inicialize the matrix
    if(gaussianColor)
        cumsum_image = zeros(size(imread(strcat(inputFolder,dirlist(1).name))));
    else
        cumsum_image = zeros(size(rgb2gray(imread(strcat(inputFolder,dirlist(1).name)))));
    end
    %Read and cummulate sum
    for ii=1:numberTraining
        if(gaussianColor)
            cumsum_image = cumsum_image + imread(strcat(inputFolder,dirlist(ii).name));
        else
            cumsum_image = cumsum_image + double(rgb2gray(imread(strcat(inputFolder,dirlist(ii).name))));
        end
    end;
    
    %Mean and standard deviation
    mean_dataset = uint8(cumsum_image / numberTraining);
    sd_dataset = uint8((((cumsum_image - (cumsum_image / numberTraining)).^2) / (numberTraining - 1)).^(1/2));

end

