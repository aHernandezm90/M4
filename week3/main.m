%M4 - Team X
%This script execute all the tasks of the second week of the project

%Get the Datasets
datasets = dir('../Dataset/');
datasets = datasets(find(vertcat(datasets.isdir)));
datasets = datasets(3:end);
nGaussians = [3,2,3];
lRate = [0.0255,0.01,0.049];
mRatio = [0.6,0.57,0.61];
param.alpha = 0.4;
param.beta = 0.6;
param.th = 0.5;
param.ts = 0.1;
outPath = {'input/Fall','input/Highway','input/Traffic'};
for dataset=1:length(datasets)
    %disp(strcat('Actual Dataset:',datasets(dataset).name))
    %disp('--------------------');
    
    %Config the data for the ForegroundDetector - Train and Classification
    inputDir = strcat('../Dataset/',datasets(dataset).name,'/input/');
    imageNames = dir(fullfile(inputDir,'*.jpg'));
    nTraining = floor(size(imageNames,1)/2);
    
    %1)Clasification of previous week
    output = classification(inputDir,imageNames,nTraining,nGaussians(dataset),lRate(dataset),mRatio(dataset));
    %disp('1)Clasification Complete');
    %Config data to catch only the test data
    %output=output1;
    %task 4
    output = uint8(output(:,:,nTraining+1:end));
    for i=1:size(output,3)
    output(:,:,i)=(imdilate(imopen(output(:,:,i),strel('disk',4)),strel('disk',4)));
    end
    imageNames = imageNames(nTraining+1:end);
    
    for  i = 1:length(imageNames)
        path = strcat('./',outPath(dataset),'/',imageNames(i).name);
%        imwrite(output(:,:,i),path{1});
    end
    

    %4)Shadow remove

    background = getBackground(inputDir,imageNames);
    %output = shadowRemove(background,output,inputDir,imageNames,param);

    
    disp('-> Classification Complete');
    
    %end) Evaluate groundthruth
    groundtruth = loadGroundtruth(datasets(dataset).name);
    groundtruth = groundtruth(:,:,nTraining+1:end);
    [TP,FP,FN,TN,F1,Recall,Precision] = datasetEvaluation(output,groundtruth);
    disp(strcat('F1:',num2str(F1)));
    %% - Task 6
    disp('... Obtaining Weighted F-measure');

    Q = WFb(double(logical(groundtruth)),logical(output));
        
    disp(strcat('Q: ',num2str(Q)));

    disp(' ');
end


    
    
