function [] = plotTpvsFrame(TP)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
TP(isnan(TP)) = 0;
figure,plot(TP);title('TP&Foreground vs Frame');
xlabel('Num of frame'); ylabel('Num of pixels');

end

