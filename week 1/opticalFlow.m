%This script execute the mandatory tasks regarding to optical flow.
%It can be applied for two different sequences.

disp('Evaluation of MSEN and PEPN');
%First we read the results for optical flow estimation (estimation and GT)
%Estimation for 000045_10
%FlowEstimation = flow_read('OpticalFlow/LKflow_000045_10.png');
%FlowGT  = flow_read('OpticalFlow/000045_10.png');
%Estimation for 000157_10
FlowEstimation = flow_read('OpticalFlow/LKflow_000157_10.png');
FlowGT  = flow_read('OpticalFlow/000157_10.png');

%Now we estimate the mean square error in non occluded areas
%Du and dv represent the two direction components of motion vectors after
%applying the Lucas-Kanade algorithm. The third dimmesion determine wether
%a pixel correspond or not to an occluded area.
FlowGT_du  = shiftdim(FlowGT(:,:,1));
FlowGT_dv  = shiftdim(FlowGT(:,:,2));
FlowGT_val = shiftdim(FlowGT(:,:,3));
FlowEstimation_du = shiftdim(FlowEstimation(:,:,1));
FlowEstimation_dv = shiftdim(FlowEstimation(:,:,2));
Error_du = FlowGT_du-FlowEstimation_du;
Error_dv = FlowGT_dv-FlowEstimation_dv;
MSEN = sqrt(Error_du.^2+Error_dv.^2);

%We only have into account the error corresponding to occluded areas.
MSEN(FlowGT_val==0) = 0;

%We get the number of pixels with a motion vector error greater than 3
numErrPixels = sum(sum(MSEN>3));

%We calculate the total amount of pixels in non occluded areas
numTotPixels = sum(sum(FlowGT_val));

%Finally we compute PEPN
PEPN = numErrPixels / numTotPixels;

%The results are shown
disp('Results:');
F_err = flow_error_image(FlowGT,FlowEstimation);
figure,imshow([flow_to_color([FlowEstimation;FlowGT]);F_err]);
figure,flow_error_histogram(FlowGT,FlowEstimation);
title(sprintf('PEPN = %.2f %%',PEPN*100));