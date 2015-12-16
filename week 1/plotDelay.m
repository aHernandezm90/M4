function [] = plotDelay(F1,F1_4,F1_10,F1_25)
%:::plotTpvsFrame::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%Plots the TP evolution of a sequence frame by frame
%Input:
%   -TP: vector with all the TP values of a sequence
%Output:
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
F1(isnan(F1)) = 0;
F1_4(isnan(F1_4)) = 0;
F1_10(isnan(F1_10)) = 0;
F1_25(isnan(F1_25)) = 0;
figure,plot([1:200],F1,[1:200],F1_4,[1:200],F1_10,[1:200],F1_25);
xlabel('Num of frame'); ylabel('F1 Score');
title('Forward de-synchronized results')
legend('Without Delay','Delay of 4 frames','Delay of 10 frames','Delay of 25 frames')
end
