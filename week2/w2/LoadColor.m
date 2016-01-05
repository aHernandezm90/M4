function [train,test,gth] = LoadColor(files,files_gth,color)

	% Allocate space for image sets
	train = zeros(240,320,3,150);
	test = zeros (240,320,3,150);
	gth = zeros (240,320,150);
	%Read the train set, test set and groundtruth
	for idx = 1:150
		if color=='rgb'
			train(:,:,:,idx) = imread(strcat('input/',files(idx).name));
			test(:,:,:,idx) = imread(strcat('input/',files(idx+150).name));
		elseif color =='hsv'
			train(:,:,:,idx) = rgb2hsv(imread(strcat('input/',files(idx).name)));
			test(:,:,:,idx) = rgb2hsv(imread(strcat('input/',files(idx+150).name)));			
		end
		gth(:,:,idx) = imread(strcat('groundtruth/',files_gth(idx+150).name));
	end
end
