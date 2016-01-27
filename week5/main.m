
%% TASK 1 %%

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

% %Traffic
% params.videoInput = 'Dataset/custom/input.avi';
% params.videoTraining = 'Dataset/custom/input.avi';
% params.nGaussians = 3;
% params.nTrainingFrames = 200;%1122;
% params.minBackgroundRatio = 0.3;
% params.learningRate = 0.0025;
% params.minimumBlobArea = 1500;
% params.areaOpen = 200;
% params.config =0;
% % Call the 1st Task
% Task1(params);

%% TASK 2 %%
% params.videoInput = 'Dataset/traffic/input.avi';
% output = Task2Train(params);

params.H = projective2d([1 0 0;4.28511 1 0.0153; 0 0 1]);
params.est = 1.4487;
params.est2real = 5;
params.vel  = 30;
%Highway
params.videoInput = 'Dataset/highway/input.avi';
params.videoTraining = 'Dataset/highway/train.avi';
params.nGaussians = 3;
params.nTrainingFrames = 300;
params.minBackgroundRatio = 0.45;
params.learningRate = 0.01;
params.minimumBlobArea = 400;
params.areaOpen = 400;
params.config = 0;

% Call the 1st Task
Task1(params);


params.H = projective2d([1 0 0;-0.9452 1 0.0043; 0 0 1]);
params.est = 25.5302;
params.est2real = 5;
params.vel  = 15;
%Traffic
params.videoInput = 'Dataset/traffic/input.avi';
params.videoTraining = 'Dataset/traffic/train.avi';
params.nGaussians = 3;
params.nTrainingFrames = 100;
params.minBackgroundRatio = 0.7;
params.learningRate = 0.0025;
params.minimumBlobArea = 2000;
params.areaOpen = 100;
params.config = 1;
% Call the 1st Task
Task1(params);
