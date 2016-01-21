% 
% %Load Data
% workingDir = 'dataset/traffic/';
% imageNames = dir(fullfile(workingDir,'*.jpg'));
% imageNames = {imageNames.name}';
% 
% %Init the Block Matcher
% hbm = vision.BlockMatcher('ReferenceFrameSource', 'Input port', 'BlockSize', [17 17]);
% hbm.OutputValue = 'Horizontal and vertical components in complex form';
% hbm.MatchCriteria = 'Mean absolute difference (MAD)';
% 
% 
% v = VideoWriter('output/task3/Video/out.avi');
% v.FrameRate = 5;
% open(v);
% previous = double(rgb2gray(imread(strcat(workingDir,imageNames{1}))));
% for i=2:101
%     
%     %Read image and compute the optical flow
%     
%     curr = double(rgb2gray(imread(strcat(workingDir,imageNames{i}))));
%     motion = step(hbm, previous, curr);
%     vx = double(real(mode(mode(motion))));
%     vy = double(imag(mode(mode(motion))));
%     
%     %Tform for wrapping
%     tform = affine2d(eye(3));
%     tform.T = tform.T + [0 0 0;0 0 0; -vx -vy 0];
%     %Wrap output and groundtruth
%     C = double(imread(strcat(workingDir,imageNames{i})));
%     D = double(imread(strcat('../Dataset/Traffic/groundtruth/',strrep(strrep(imageNames{i},'in','gt'),'jpg','png'))));
%     [x, y] = meshgrid(1:size(C,2), 1:size(C,1));
%     for j=1:3
%      outc(:,:,j) = imwarp(C(:,:,j), tform,'OutputView',imref2d(size(curr)));
%     end
%     outg = imwarp(D, tform,'OutputView',imref2d(size(curr)));
%     out = imwarp(curr, tform,'OutputView',imref2d(size(curr)));
%     imwrite(uint8(outc),strcat('output/task3/Images/Output/',imageNames{i}));
%     imwrite(uint8(outg),strcat('output/task3/Images/Groundtruth/',strrep(strrep(imageNames{i},'in','gt'),'jpg','png')));
%     writeVideo(v,uint8(outc));
%     previous = out;
% end
% close(v);


%Evaluate
% 
% 
% 
% Load Data
% workingDir = 'dataset/traffic/';
% imageNames = dir(fullfile(workingDir,'*.jpg'));
% imageNames = {imageNames.name}';
% groundtruth = loadGroundtruth('dataset/');
% groundtruth = groundtruth(:,:,nTraining+1:end);
% pF1=[];
% pR=[];
% pP=[];
% pFp=[];
% pTp=[];
% 
% 
% for i=0.001:0.01:0.201
% output = uint8(size(size(imageNames,1)));
% output = classification(workingDir,imageNames,nTraining,3,i,0.61);
% nTraining = floor(size(imageNames,1)/2);
% output = uint8(output(:,:,nTraining+1:end));
% [TP,FP,FN,TN,F1,Recall,Precision] = datasetEvaluation(output,groundtruth);
% pF1 = [pF1 F1];
% pR = [pR Recall];
% pP = [pP Precision];
% pFp =[pFp FP];
% pTp = [pTp TP];
% end
% 
% [~, idx] = sort(pR,'ascend')
% auc = trapz(pR(idx),pP(idx))
% plot(pR,pP)
% xlabel('Recall'); ylabel('Precision');
% title(strcat('Precision Recall curve.',' AUC=',num2str(auc),'. Max F1=',num2str(max(pF1))));

%Load Data
workingDir = 'Output/task3/Images/Output/';
imageNames = dir(fullfile(workingDir,'*.jpg'));
imageNames = {imageNames.name}';
groundtruth = loadGroundtruth('Output/task3/Images/');
groundtruth = groundtruth(:,:,nTraining+1:end);
pF1=[];
pR=[];
pP=[];
pFp=[];
pTp=[];


for i=0.001:0.01:0.201
%output = uint8(size(size(imageNames,1)));
output = classification(workingDir,imageNames,nTraining,3,i,0.61);
nTraining = floor(size(imageNames,1)/2);
output = uint8(output(:,:,nTraining+1:end));
[TP,FP,FN,TN,F1,Recall,Precision] = datasetEvaluation(output,groundtruth);
pF1 = [pF1 F1];
pR = [pR Recall];
pP = [pP Precision];
pFp =[pFp FP];
pTp = [pTp TP];
end

[~, idx] = sort(pR,'ascend')
auc = trapz(pR(idx),pP(idx))
plot(pR,pP)
xlabel('Recall'); ylabel('Precision');
title(strcat('Precision Recall curve.',' AUC=',num2str(auc),'. Max F1=',num2str(max(pF1))));




