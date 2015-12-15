
%Variables
FN = [0 0]; TN = FN; FP = TN; TP = FP; Precision = TP ;Recall = Precision; F1 = Recall;

%N files in the folder
imagefiles = dir('Dataset/Dataset1/*.png');      
nfiles = length(imagefiles);

for ii=1:nfiles
   
    %Read image 
    currentfilename = imagefiles(ii).name
    currentimage = imread(strcat('Dataset/Dataset1/',currentfilename));

    %Wich db A / B
    st = strsplit(currentfilename,'_');
    db = char(st{2});
    name = char(st{3});
    st = strcat('groundtruth/gt',name);
    ground = imread(st);

    %Select the object of the groundtruth
    ground = ground == 255;
    
    %Pixel evaluation of the current image
    [pixelTP, pixelFP, pixelFN, pixelTN] = PixelEvaluation(currentimage,ground);
    
%     %All the images
%     if (db=='A')
%         TP(1) = TP(1) + pixelTP;
%         FP(1) = FP(1) + pixelFP;
%         FN(1) = FN(1) + pixelFN;
%         TN(1) = TN(1) + pixelTN;
%     else
%         TP(2) = TP(2) + pixelTP;
%         FP(2) = FP(2) + pixelFP;
%         FN(2) = FN(2) + pixelFN;
%         TN(2) = TN(2) + pixelTN;
%     end
    %Get plotting parameters 
    Precision = pixelTP / (pixelTP+pixelFP);
    Recall = pixelTP / (pixelTP+pixelFN);
    F1(ii) = (2*Precision*Recall) / (Precision + Recall);
    TPandFreground(ii) = pixelTP;
end
%Plot F1vsFrame
F1(isnan(F1)) = 0;
figure(1);plot(F1);title('F1 score vs Frame');
xlabel('Num of frame'); ylabel('F1 score');

%Plot TPvsFrame
TPandFreground(isnan(TPandFreground)) = 0;
figure(2);plot(TPandFreground);title('TP&Foreground vs Frame');
xlabel('Num of frame'); ylabel('Num of pixels');

% Precision = TP ./ (TP+FP);
% Recall = TP ./ (TP+FN);
% F1 = (2*Precision.*Recall) ./ (Precision + Recall);

