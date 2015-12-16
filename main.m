
%Variables
FN = 0; TN = FN; FP = TN; TP = FP; Precision = TP ;Recall = Precision; F1 = Recall;

%Select the dataset to be analazyed (A or B)
db = 'B';
dbPath = strcat('Dataset/Dataset1/',db,'/');
%Calculate the number of files in the folder
imagefiles = dir(dbPath); 
resultList = deleteHiddenFiles(imagefiles);
nfiles = length(resultList);

for ii=1:nfiles
   
    %Read image 
    currentfilename = resultList(ii).name;
    currentimage = imread(strcat(dbPath,currentfilename));
    
    %Read ground truth
    st = strsplit(currentfilename,'_');
    name = char(st{3});
    gtPath = strcat('Groundtruth/gt',name);
    ground = imread(gtPath);

    %Select the object of the groundtruth
    ground = ground == 255;
    
    %Pixel evaluation of the current image
    [pixelTP, pixelFP, pixelFN, pixelTN] = PixelEvaluation(currentimage,ground);
    
    TP = TP + pixelTP;
    FP = FP + pixelFP;
    FN = FN + pixelFN;
    TN = TN + pixelTN;

    %Get plotting parameters 
    Precision = pixelTP / (pixelTP+pixelFP);
    Recall = pixelTP / (pixelTP+pixelFN);
    F1(ii) = (2*Precision*Recall) / (Precision + Recall);
    TPandFreground(ii) = pixelTP;
end
%Plot F1vsFrame
plotF1vsFrame(F1);

%Plot TPvsFrame
plotTpvsFrame(TPandFreground);

%Compute metrics
[Precision,Recall,F1] = computeMetrics(TP,FP,FN);

