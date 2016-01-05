function img_final = Adaptive(img_res,test,media,dstd,alpha,p)
	for im=1:75
		for x= 1:size(img_res(:,:,im),1)
			for y =1:size(img_res(:,:,im),2)
				if abs(img_res(x,y,im))>=alpha*(dstd(x,y)+2)
					img_final(x,y,im)=1;
					media(x,y) = p*test(x,y,im) +(1-p)*media(x,y);
					dstd(x,y) = sqrt(p*img_res(x,y,im)^2 + (1-p)*dstd(x,y)^2);
				else
					img_final(x,y,im) =0;
				end
			end
		end
	end
	img_final(:,:,76:end) = bsxfun(@gt,abs (img_res(:,:,76:end)),alpha*(dstd + 2));
end