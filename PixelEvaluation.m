function [pixelTP, pixelFP, pixelFN, pixelTN]  = PixelEvaluation( currentimage,ground )
%PIXELEVALUATION Summary of this function goes here
%   Detailed explanation goes here
    pixelTP = sum(sum(currentimage>0 & ground>0));
    pixelFP = sum(sum(currentimage>0 & ground==0));
    pixelFN = sum(sum(currentimage==0 & ground>0));
    pixelTN = sum(sum(currentimage==0 & ground==0));

end

