function [ output ] = classification( inputdir,imageNames,nTraining,nGaussians,lRate,mRatio )
%CLASSIFICATION Summary of this function goes here
%   Detailed explanation goes here
foregroundDet = vision.ForegroundDetector('MinimumBackgroundRatio',mRatio,'NumGaussians',nGaussians,'LearningRate',lRate,'NumTrainingFrames',nTraining,'InitialVariance', 30*30);
img_size = size(imread(fullfile(inputdir,imageNames(1).name)));
img_size = img_size(1:2);
output = zeros([img_size size(imageNames,1)]);
for ii = 1:length(imageNames)
    img = imread(fullfile(inputdir,imageNames(ii).name));
    %img = rgb2hsv(img);
    output(:,:,ii) = foregroundDet.step(img);
    
end

end

