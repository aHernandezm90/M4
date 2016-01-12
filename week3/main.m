%M4 - Team X
%This script execute all the tasks of the second week of the project


%Get the Datasets
datasets = dir('../Dataset/');
datasets = datasets(find(vertcat(datasets.isdir)));
datasets = datasets(3:end);
nGaussians = [3,2,3];
lRate = [0.0255,0.01,0.049];
mRatio = [0.6,0.57,0.61];

for dataset=1:length(datasets)
    disp(strcat('Actual Dataset:',datasets(dataset).name))
    disp('--------------------');
    
    %Config the data for the ForegroundDetector - Train and Classification
    inputDir = strcat('../Dataset/',datasets(dataset).name,'/input/');
    imageNames = dir(fullfile(inputDir,'*.jpg'));
    nTraining = floor(size(imageNames,1)/2);
    
    %1)Clasification of previous week
    output = classification(inputDir,imageNames,nTraining,nGaussians(dataset),lRate(dataset),mRatio(dataset));
    
    
    disp('-> Classification Complete');
    
    %end) Evaluate groundthruth
    groundtruth = loadGroundtruth(datasets(dataset).name);
    [TP,FP,FN,TN,F1,Recall,Precision] = datasetEvaluation(output,groundtruth);
    disp(strcat('F1:',num2str(F1)));
    %% - Task 6
    disp('... Obtaining Weighted F-measure');

    Q = WFb(double(logical(groundtruth)),logical(output));
        
    disp(strcat('Q: ',num2str(Q)));

    disp(' ');
end


    
    
