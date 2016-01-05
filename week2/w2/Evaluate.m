function [tp,tn,fp,fn] = Evaluate(gth,img_final)

	tmp = zeros(size(img_final));
	tmp(img_final(:,:,:)==1 & gth==255)=1;
	tp = sum(sum(sum(tmp)));
	tmp = zeros(size(img_final));
	tmp(img_final(:,:,:)==1 & (gth ==0 | gth == 50))=1;
	fp = sum(sum(sum(tmp)));
	tmp = zeros(size(img_final));
	tmp(img_final(:,:,:)==0 & (gth==0 | gth ==50))=1;
	% imshow ([tmp(:,:,145),img_final(:,:,145)])
	% pause;
	tn = sum(sum(sum(tmp)));
	tmp = zeros(size(img_final));
	tmp(img_final(:,:,:)==0 & gth==255)=1;
	fn = sum(sum(sum(tmp)));
end