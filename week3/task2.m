%Se toma como input la salida de task 1 (conn4 o conn 8, el que haya dado mejor F1)
%Task2
datasetTrafficPath = '../week3/input/Traffic/';
datasetHighwayPath = '../week3/input/Highway/';
datasetFallPath = '../week3/input/Fall/';
resultsTrafficPath = '../week3/results/bwareaopen/Traffic/';
resultsHighwayPath = '../week3/results/bwareaopen/Highway/';
resultsFallPath = '../week3/results/bwareaopen/Fall/';
datasetPath = {datasetTrafficPath,datasetHighwayPath,datasetFallPath};
resultsPath = {resultsTrafficPath,resultsHighwayPath,resultsFallPath};
%Build dir for placing results
for i = 1:3
    mkdir(resultsPath{i});
end

for i = 1:3
    %Apply hole filling
    %Obtain list of files
    listFiles = dir(datasetPath{i});
    listFiles = listFiles(3:end);
    numFiles = length(listFiles);
    %Compute every image
    for j = 1:numFiles
        fileName = listFiles(j).name;
        originalImage = logical(imread(strcat(datasetPath{i},fileName)));
        filteredImage = bwareaopen(originalImage,20);
        imwrite(filteredImage,strcat(resultsPath{i},fileName));
    end
end