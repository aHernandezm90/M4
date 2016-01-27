function CreateVideo( inputFolder, videoName )
%CREATEVIDEO Summary of this function goes here
%   Detailed explanation goes here
v = VideoWriter(strcat(videoName,'.avi'));
open(v);

workingDir = inputFolder;
imageNames = dir(fullfile(workingDir,'*.jpg'));
imageNames = {imageNames.name}';

for i=1:size(imageNames,1)
    writeVideo(v,imread(strcat(workingDir,imageNames{i})));
end

close(v);

end

