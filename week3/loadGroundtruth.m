function [ output ] = loadGroundtruth( name )
%LOADGROUNDTHRUTH Summary of this function goes here
%   Detailed explanation goes here
    inputDir = strcat('../Dataset/',name,'/groundtruth/');
    imageNames = dir(fullfile(inputDir,'*.png'));
    img_size = size(imread(fullfile(inputDir,imageNames(1).name)));
    img_size = img_size(1:2);
    output = zeros([img_size size(imageNames,1)]);
    for ii = 1:length(imageNames)
        output(:,:,ii) = imread(fullfile(inputDir,imageNames(ii).name));
    end

end

