
% 
% %Highway
% params.videoInput = 'Dataset/highway/input.avi';
% params.videoTraining = 'Dataset/highway/train.avi';
% params.nGaussians = 3;
% params.nTrainingFrames = 300;
% params.minBackgroundRatio = 0.45;
% params.learningRate = 0.01;
% params.minimumBlobArea = 400;
% params.areaOpen = 400;
% params.config = 0;
% % Call the 1st Task
% Task1(params);

% %Traffic
% params.videoInput = 'Dataset/traffic/input.avi';
% params.videoTraining = 'Dataset/traffic/train.avi';
% params.nGaussians = 3;
% params.nTrainingFrames = 100;
% params.minBackgroundRatio = 0.7;
% params.learningRate = 0.0025;
% params.minimumBlobArea = 2000;
% params.areaOpen = 100;
% params.config = 1;
% % Call the 1st Task
% Task1(params);

%Traffic
params.videoInput = 'Dataset/custom/input.avi';
params.videoTraining = 'Dataset/custom/input.avi';
params.nGaussians = 3;
params.nTrainingFrames = 200;%1122;
params.minBackgroundRatio = 0.3;
params.learningRate = 0.0025;
params.minimumBlobArea = 1500;
params.areaOpen = 200;
params.config =0;
% Call the 1st Task
Task1(params);