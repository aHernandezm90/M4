function [train,test,gth] = Load(files,files_gth)

	% Allocate space for image sets
	train = zeros(240,320,150);
	test = zeros (240,320,150);
	gth = zeros (240,320,150);
	%Read the train set, test set and groundtruth
	for idx = 1:150
		train(:,:,idx) = rgb2gray (imread(strcat('input/',files(idx).name)));
		test(:,:,idx) = rgb2gray (imread(strcat('input/',files(idx+150).name)));
		gth(:,:,idx) = imread(strcat('groundtruth/',files_gth(idx+150).name));
	end
end
