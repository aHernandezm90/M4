function [] = plotF1vsFrame(F1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
F1(isnan(F1)) = 0;
figure,plot(F1);title('F1 score vs Frame');
xlabel('Num of frame'); ylabel('F1 score');

end

