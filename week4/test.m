v = VideoWriter('out.avi');
v.FrameRate = 5;
open(v);

workingDir = 'dataset/traffic/';
imageNames = dir(fullfile(workingDir,'*.jpg'));
imageNames = {imageNames.name}';

for i=1:101
    writeVideo(v,imread(strcat(workingDir,imageNames{i})));
end

close(v);