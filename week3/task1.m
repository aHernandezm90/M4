%Task1
%Para el imfill y bwareaopen se necesitan las imagenes generadas
%anteriormente que estaran en las rutas datasetTrafficPath,
%datasetHighwayPath y datasetFallPath.Se almacenaran en la carpeta results
%conn4 y conn8 dependiendo de la conectividad.
datasetTrafficPath = 'input/Traffic/';
datasetHighwayPath = 'input/Highway/';
datasetFallPath = 'input/Fall/';
resultsTrafficPath = 'results/imfill/conn8/Traffic/';
resultsHighwayPath = 'results/imfill/conn8/Highway/';
resultsFallPath = 'results/imfill/conn8/Fall/';
connectivity = 8; %Cambiar conectividad, 4 u 8
locations = [3 3];
datasetPath = {datasetTrafficPath,datasetHighwayPath,datasetFallPath};
resultsPath = {resultsTrafficPath,resultsHighwayPath,resultsFallPath};
datasetsNames = {'Traffic','Highway','Fall'};
datasets = {'../Dataset/Traffic/input/','../Dataset/Highway/input/','../Dataset/Fall/input/'};
% %Build dir for placing results
% for i = 1:3
%     mkdir(datasetPath{i});
% end
% for i = 1:3
%     mkdir(resultsPath{i});
% end
% 
% for i = 1:3
%     %Apply hole filling
%     %Obtain list of files
%     listFiles = dir(datasetPath{i});
%     listFiles = listFiles(3:end);
%     numFiles = length(listFiles);
%     %Compute every image
%     for j = 1:numFiles
%         fileName = listFiles(j).name;
%         originalImage = logical(imread(strcat(datasetPath{i},fileName)));
%         filledImage = imfill(originalImage,connectivity,'holes');
%         imwrite(filledImage,strcat(resultsPath{i},fileName));
%     end
% end


for i=1:length(resultsPath)
    imageNames = dir(fullfile(datasets{i},'*.jpg'));
    nTraining = floor(size(imageNames,1)/2);
    groundtruth = loadGroundtruth(datasetsNames{i});
    groundtruth = groundtruth(:,:,nTraining+1:end);
    outputNames = dir(fullfile(resultsPath{i},'*.jpg'));
    for j = 1:nTraining+1
        output(:,:,j) = logical(imread(strcat(resultsPath{i},outputNames(j).name)));
    end
    disp(strcat('-----Dataset:',datasetsNames{i},'-----'));
    disp(strcat('F1:',num2str(F1),'Precision:',num2str(Precision),'Recall:',num2str(Recall)));
    output = [];
end


