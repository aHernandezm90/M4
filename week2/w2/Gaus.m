function img_final = Gaus(img_res,alpha,dstd)
	img_final = bsxfun(@gt,abs (img_res),alpha*(dstd + 2));
end
