%Task1
%Para el imfill y bwareaopen se necesitan las imagenes generadas
%anteriormente que estaran en las rutas datasetTrafficPath,
%datasetHighwayPath y datasetFallPath.Se almacenaran en la carpeta results
%conn4 y conn8 dependiendo de la conectividad.
datasetTrafficPath = '../week3/input/Traffic/';
datasetHighwayPath = '../week3/input/Highway/';
datasetFallPath = '../week3/input/Fall/';
resultsTrafficPath = '../week3/results/imfill/conn4/Traffic/';
resultsHighwayPath = '../week3/results/imfill/conn4/Highway/';
resultsFallPath = '../week3/results/imfill/conn4/Fall/';
connectivity = 4; %Cambiar conectividad, 4 u 8
locations = [3 3];
datasetPath = {datasetTrafficPath,datasetHighwayPath,datasetFallPath};
resultsPath = {resultsTrafficPath,resultsHighwayPath,resultsFallPath};
%Build dir for placing results
for i = 1:3
    mkdir(datasetPath{i});
end
for i = 1:3
    mkdir(resultsPath{i});
end

for i = 1:3
    %Apply hole filling
    %Obtain list of files
    listFiles = deleteHiddenFiles(dir(datasetPath{i}));
    numFiles = length(listFiles);
    %Compute every image
    for j = 1:numFiles
        fileName = listFiles(j).name;
        originalImage = logical(imread(strcat(datasetPath{i},fileName)));
        filledImage = imfill(originalImage,locations,connectivity);
        imwrite(~filledImage,strcat(resultsPath{i},fileName));
    end
end


