%Se toma como input la salida de task 1 (conn4 que es el que ha dado mejores resultados)
%Task2
datasetTrafficPath = 'input/Traffic/';
datasetHighwayPath = 'input/Highway/';
datasetFallPath = 'input/Fall/';
datasetPath = {datasetTrafficPath,datasetHighwayPath,datasetFallPath};
datasetsNames = {'Traffic','Highway','Fall'};
datasets = {'../Dataset/Traffic/input/','../Dataset/Highway/input/','../Dataset/Fall/input/'};
tam = [1 3 5 7 10 12 15 20 30 50];
%Build dir and compute bwareaopen 
for i = 1:length(tam)
    pathGen = strcat('results/bwareaopen/tam',num2str(tam(i)),'/');
    mkdir(pathGen);
    for j = 1:3
        mkdir(strcat(pathGen,datasetsNames{j}));
        listFiles = dir(fullfile(datasetPath{j},'*.jpg'));
        numFiles = length(listFiles);
        for k = 1:numFiles
            fileName = listFiles(k).name;
            originalImage = logical(imread(strcat(datasetPath{j},fileName)));
            %filteredImage = bwareaopen(originalImage,tam(i));
            filteredImage = originalImage;
            imwrite(filteredImage,strcat(pathGen,datasetsNames{j},'/',fileName));
        end
    end
end

%Evaluate results
for i = 1:length(tam)
    disp(strcat('::::::::::::Tamaño ',num2str(tam(i)),':::::::::::::::'));
    pathGen = strcat('results/bwareaopen/tam',num2str(tam(i)),'/');
    for j = 1:3
        imageNames = dir(fullfile(datasets{j},'*.jpg'));
        nTraining = floor(size(imageNames,1)/2);
        groundtruth = loadGroundtruth(datasetsNames{j});
        groundtruth = groundtruth(:,:,nTraining+1:end);
        outputNames = dir(fullfile(strcat(pathGen,datasetsNames{j}),'*.jpg'));
        for k = 1:nTraining+1
            output(:,:,k) = logical(imread(strcat(pathGen,datasetsNames{j},'/',outputNames(k).name)));
        end
        [TP,FP,FN,TN,F1,Recall,Precision] = datasetEvaluation(output,groundtruth);
        disp(strcat('-----Dataset:',datasetsNames{j},'-----'));
        disp(strcat('F1:',num2str(F1),'Precision:',num2str(Precision),'Recall:',num2str(Recall)));
        output = [];
    end
end



