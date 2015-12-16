function [Precision,Recall,F1] = computeMetrics(TP,FP,FN)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Precision = TP ./ (TP+FP);
Recall = TP ./ (TP+FN);
F1 = (2*Precision.*Recall) ./ (Precision + Recall);

end

