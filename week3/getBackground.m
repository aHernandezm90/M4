function [ background_mean ] = getBackground( inputDir , imageNames )
%GETBACKGROUND Summary of this function goes here
%   Detailed explanation goes here

img_size = size(imread(fullfile(inputDir,imageNames(1).name)));
output = zeros(img_size);
for ii = 1:floor(length(imageNames)/2)
    %img = rgb2hsv(img);
    output(:,:,:) = output(:,:,:) + double(imread(fullfile(inputDir,imageNames(ii).name)));
    
end
    
background_mean = uint8(output/(floor(length(imageNames)/2)));
end

