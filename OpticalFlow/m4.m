clc;clear all; close all

% Task 4 --------------------------------------------------------
disp ('---------------------Task 4-----------------------')
% error threshold
tau = 3;
i_est = flow_read('ima/est/LKflow_000157_10.png');
i_gt = flow_read('ima/gt/000157_10.png');

err = flow_error(i_gt,i_est,tau);

disp (sprintf('Error = %d',err))
i_err = flow_error_image (i_gt,i_est);

figure,imshow([flow_to_color([i_est;i_gt]);i_err]);
title(sprintf('Error: %.2f %%',err*100));
figure,flow_error_histogram(i_gt,i_est);

% Task 6 ---------------------------------------------------------
disp ('---------------------Task 6 -----------------------')
im2 = imread('ima/train/000157_11.png');

figure
imshow(im2)
hold on
u = i_est(:,:,1);
v = i_est(:,:,2);

%Resize u and v so we can actually see something in the quiver plot
factor = 50/size(u,2);
u_ = factor*imresize(u,factor,'bilinear');
v_ = factor*imresize(v,factor,'bilinear');
%Run quiver taking into account matlab coordinate system quirkiness
%and scaling the magnitude of (u,v) by 2 so it is more visible.
quiver(u_(end:-1:1,:),-v_(end:-1:1,:),4);
axis('tight');
%-----------------------------------------------------------------------
%original
hold off

figure, imshow(im2);
hold on
u = i_est(:,:,1);
v = i_est(:,:,2);
quiver(u(end:-1:1,:),-v(end:-1:1,:),4);
hold off
%----------------------------------------------------------------------
% good view
g=figure;
imshow(im2);
hold on
u1=blockproc(u,[8 8],@block_mean);
v1=blockproc(v,[8 8],@block_mean);
quiver(1:8:size(im2,2),1:8:size(im2,1),u1(end:-1:1,:),-v1(end:-1:1,:),4);
saveas(g, 'good.png')
hold off
%---------------------------------------------------------------------
