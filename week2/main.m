%M4 - Team X
%This script execute all the tasks of the second week of the project


%CONFIG PARAMETERS
param.gaussianColor = false;
%Value between [-2.5,2.5]
param.alpha = 0.1;
param.maxAlpha = 5.0;
param.minAlpha = 0;

%------------------
%Gaussian Modelling
%------------------

%-------Task 1-----------

%Get the Datasets
datasets = dir('Dataset/');
datasets = datasets(find(vertcat(datasets.isdir)));
datasets = datasets(3:end);

for i=1:length(datasets)
    
    %Training 
    %---------
    %List the images for training
    inputFolder = strcat('Dataset/',datasets(i).name,'/input/');
    dirList = dir(inputFolder);
    %Remove the . .. from the list
    dirList = dirList(3:end);
    %Use the half of the Dataset to train
    numberTraining = floor(length(dirList) / 2);
    
    [mean_dataset{i}, sd_dataset{i}] = GaussianTraining(inputFolder,dirList,numberTraining,param.gaussianColor);
    
    %Testing
    %-------
    %[output{i}] = GaussianTesting(inputFolder,dirList,mean_dataset{i},sd_dataset{i},numberTraining,param.gaussianColor,param.alpha,true);

end

%-------Task 2/3-----------
TP = zeros([length(datasets) (param.maxAlpha+abs(param.minAlpha))/0.1]); FP=TP;FN=FP;TN=FN;F1=TN;Recall=F1;
for i=1:length(datasets)
    %List the testing images
    inputFolder = strcat('Dataset/',datasets(i).name,'/input/');
    dirList = dir(inputFolder);
    dirList = dirList(3:end);
    %List the groundtruth images
    groundtruthFolder = strcat('Dataset/',datasets(i).name,'/groundtruth/')
    groundtruthList = dir(groundtruthFolder);
    groundtruthList = groundtruthList(3:end);
    numberTraining = floor(length(dirList) / 2);
    
    t=1;
    
    %Inicialize the matrix
    imsize = size(imread(strcat(groundtruthFolder,groundtruthList(1).name)));
    if(param.gaussianColor)
        groundtruth = zeros([imsize length(dirList)-numberTraining+1 ]);
    else
        groundtruth = zeros([imsize(1:2) length(dirList)-numberTraining+1 ]);
    end
    
    for ii=numberTraining+1:length(dirList)
        if(param.gaussianColor)
            groundtruth(:,:,:,ii-numberTraining) = imread(strcat(groundtruthFolder,strrep(groundtruthList(ii).name,'in','gt'))) == 255;
        else
            groundtruth(:,:,ii-numberTraining) = imread(strcat(groundtruthFolder,strrep(groundtruthList(ii).name,'in','gt'))) == 255;
        end
    end;
    
    for ii=param.minAlpha:0.1:param.maxAlpha
        ii
        [output] = GaussianTesting(inputFolder,dirList,mean_dataset{i},sd_dataset{i},numberTraining,param.gaussianColor,ii,false);
        [TP(i,t),FP(i,t),FN(i,t),TN(i,t),F1(i,t),Recall(i,t)] = GaussianEvaluation(output,groundtruth);
        t=t+1;
    end
end

%Ploting Data
for i=1:length(datasets)
    len = length(TP(i,:));
    figure,
    plot((1:len),TP(i,:),(1:len), FP(i,:),(1:len), FN(i,:),(1:len), TN(i,:))
%     set(gca,'XTick',1:10:len )
     set(gca,'XTickLabel',param.minAlpha:0.1*10:param.maxAlpha )
    legend('TP','FP','FN','TN')
    title(strcat('Evaluation - Non-recursive Gaussian modeling - "',datasets(i).name,'" Dataset'))
    xlabel('\alpha Threshold')
    ylabel('Nº Pixels')
end

for i=1:length(datasets)
    figure,
    plot(1:length(F1(i,:)),F1(i,:))
    %Max F1
    [y x] = max(F1(i,:))
    hold on
    plot(x,y,'o','MarkerSize',10)
    strmax = ['\alpha = ',num2str(x*0.1), ' | F1 Score = ',num2str(F1(i,x))];
    text(x,y,strmax,'HorizontalAlignment','left');
    %Min F1
    [y x] = min(F1(i,:))
    hold on
    plot(x,y,'o','MarkerSize',10)
    strmax = ['\alpha = ',num2str(x*0.1), ' | F1 Score = ',num2str(F1(i,x))];
    text(x,y,strmax,'HorizontalAlignment','left');
    %Plot parameters
%     set(gca,'XTick',1:10:len )
    set(gca,'XTickLabel',param.minAlpha:0.1*10:param.maxAlpha )
    title(strcat('F1 Score - Non-recursive Gaussian modeling - "',datasets(i).name,'" Dataset'))
    xlabel('\alpha Threshold')
    ylabel('F1 Score')
end


  