function [] = plotF1vsFrame(F1)
%:::plotF1vsFrame::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%Plots the F1 score evolution of a sequence frame by frame
%Input:
%   -F1: vector with all the F1 scores of a sequence
%Output:
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
F1(isnan(F1)) = 0;
figure,plot(F1);title('F1 score vs Frame');
xlabel('Num of frame'); ylabel('F1 score');

end

