function [] = plotTpvsFrame(TP)
%:::plotTpvsFrame::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%Plots the TP evolution of a sequence frame by frame
%Input:
%   -TP: vector with all the TP values of a sequence
%Output:
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
TP(isnan(TP)) = 0;
figure,plot(TP);title('TP&Foreground vs Frame');
xlabel('Num of frame'); ylabel('Num of pixels');

end

