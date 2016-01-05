%----------------------------------------------------------------------
% load image
files = dir('input/*.jpg');
files_gth = dir('groundtruth/*.png');
[train,test,gth] = Load (files,files_gth);
%[train,test,gth] = LoadColor(files,files_gth,'hsv');
color =0;
%----------------------------------------------------------------------
media = mean(train,3);
dstd = std (train,0,3);
test = double (test);
media = double (media);
img_res = bsxfun(@minus,test,media);
%----------------------------------------------------------------------
% Segmentacion con gausiana 
alpha = [0.5:0.5:2.0];
tp = zeros (size(alpha));
tn = zeros (size(alpha));
fp = zeros (size(alpha));
fn = zeros (size(alpha));
precision = zeros (size(alpha));
recall = zeros (size(alpha));
ind= 1;
for idx = alpha
	img_final = Gaus(img_res,idx,dstd);
	%img_final = Adaptive(img_res,test,media,dstd,idx,p);
	if color ==1
		img_final= img_final(:,:,1,:) & img_final(:,:,2,:) & img_final(:,:,3,:); 
	end
	[tp(ind),tn(ind),fp(ind),fn(ind)] = Evaluate(gth,img_final);

	precision(ind) = tp(ind)/(tp(ind)+fp(ind));
	recall(ind) = tp(ind)/(tp(ind)+fn(ind));
	f1(ind) = 2* precision(ind)*recall(ind) / (precision(ind) +recall(ind));  
	ind = ind+1;
end

PlotRes(tp,tn,fp,fn,precision,recall,f1,alpha);