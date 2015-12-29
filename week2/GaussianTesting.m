function [ out ] = GaussianTesting( inputFolder,dirList,mean_dataset,sd_dataset,numberTraining,gaussianColor,alphaVal,WriteResults)
%Testing for the Non-recursive Gaussian modeling for background substraction
%The function compute the backgraund substraction of a set of images

%Inicialize the matrix
imsize = size(imread(strcat(inputFolder,dirList(1).name)));
if(gaussianColor)
    out = zeros([imsize length(dirList)-numberTraining+1]);
else
    out = zeros([imsize(1:2) length(dirList)-numberTraining+1 ]);
end

i=1;

for ii=numberTraining+1:length(dirList)
    
    if(gaussianColor)
        current_image = rgb2gray(imread(strcat(inputFolder,dirList(ii).name)));
        %Background
        out(:,:,i) = abs(current_image-mean_dataset) >= (alphaVal*(sd_dataset+2));
        if(WriteResults)
            imwrite(out(:,:,i),strrep(inputFolder, '/input/', '/results/'));
        end
    else
        current_image = rgb2gray(imread(strcat(inputFolder,dirList(ii).name)));
        %Background
        out(:,:,i) = abs(current_image-mean_dataset) >= (alphaVal*(sd_dataset+2));
        if(WriteResults)
            imwrite(out(:,:,i),strcat(strrep(inputFolder, '/input/', '/results/'),int2str(ii),'.png'));
        end    
    end
    i=i+1;
end;

end

