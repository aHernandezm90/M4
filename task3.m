
workingDir = 'dataset/traffic/';
imageNames = dir(fullfile(workingDir,'*.jpg'));
imageNames = {imageNames.name}';
%imageNames = flipud(imageNames);

hbm = vision.BlockMatcher('ReferenceFrameSource', 'Input port', 'BlockSize', [31 31]);
hbm.OutputValue = 'Horizontal and vertical components in complex form';

x = 0;
y = 0;
b2 = [];
b1 = [];
bmean = [];
previous = double(rgb2gray(imread(strcat(workingDir,imageNames{1}))));
i=0;
v = VideoWriter('output/task3/Video/out.avi');
v.FrameRate = 15;
open(v);
for i=2:101
    
    %Read image and compute the optical flow
    curr = double(rgb2gray(imread(strcat(workingDir,imageNames{i}))));
    motion = step(hbm, previous, curr);
    vx = real(mean(mean(motion)));
    vy = imag(mean(mean(motion)));
    
    %Data for plot movement of pixels ( Don't accumulate result because we
    %compare the next frame with the modified frame
    b1 = [b1 motion(8,1)];
    b2 = [b2 motion(4,5)];
    bmean = [bmean mean(mean(motion))];
    
    %Wrap output and groundtruth
    C = double(imread(strcat(workingDir,imageNames{i})));
    D = double(imread(strcat('../Dataset/Traffic/groundtruth/',strrep(strrep(imageNames{i},'in','gt'),'jpg','png'))));
    [x, y] = meshgrid(1:size(C,2), 1:size(C,1));
    for j=1:3
     outc(:,:,j) = interp2(double(C(:,:,j)), x-vx, y-vy);
    end
    outg = interp2(double(D), x-vx, y-vy);
    out = interp2(double(curr), x-vx, y-vy);
    writeVideo(v,uint8(outc));
    %Save the images
    previous = out;
    imwrite(uint8(outc),strcat('output/task3/Images/Output/',imageNames{i}));
    imwrite(uint8(outg),strcat('output/task3/Images/Groundtruth/',strrep(strrep(imageNames{i},'in','gt'),'jpg','png')));
    pause(0.01);
    i=i+1;
end
close(v);

subplot(3,1,1);
plot(imag(b1))
subplot(3,1,2);
plot(imag(b2));
subplot(3,1,3);
plot(imag(bmean));