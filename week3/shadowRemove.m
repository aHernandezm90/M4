function [ output ] = shadowRemove( background,output,inputDir,imageNames,param)
%SHADOWREMOVE Summary of this function goes here
%   Detailed explanation goes here

background = rgb2hsv(background);
for ii = 1:length(imageNames)
    img = imread(fullfile(inputDir,imageNames(ii).name));
    img = rgb2hsv(img);
    shadow = ((img(:,:,3) ./ background(:,:,3) ) >= param.alpha) .* ((img(:,:,3) ./ background(:,:,3) ) <= param.beta);
    shadow = shadow .* ((img(:,:,2)-background(:,:,2)) <=param.ts);
    shadow = uint8(shadow .* ((img(:,:,1)-background(:,:,1)) <=param.th));
    output(:,:,ii) = output(:,:,ii) - ( output(:,:,ii) .* shadow );
    %output(:,:,ii) = output(:,:,ii).*255;
end

end

