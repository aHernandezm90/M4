
function main(tras)

    global msev;
    global N;
    global I1;                 
    global motion_vectors;   
    global prediction_errors;                              
    global actual_positions;  

    
    N=tras;
    msev=[];

    files = dir('dataset/kitti/*.png');
    for idx =1:2:size(files)
        previous_frames = files(idx).name;
        current_frames = files(idx+1).name;
    
        motion_vectors = [];
        actual_positions = [];

        if size(I1,3) == 3
            I1 = rgb2gray(imread(strcat('dataset/kitti/',previous_frame)));%strcat(previous_frames{i}, '.png')));
            I2 = rgb2gray(imread(stracat('dataset/kitti',current_frames)));%strcat(current_frames{i}, '.png')));
        else
            I1 = imread(strcat('dataset/kitti/',previous_frames));
            I2 = imread(strcat('dataset/kitti/',current_frames));
        end
        I1 = imresize(I1,size(I1)-mod(size(I1),8));
        I2 = imresize(I2,size(I2)-mod(size(I2),8));
        figure ('name',previous_frames,'NumberTitle','off')

        imshow (I2);
        hold on
        prediction_errors = blockproc(I2, [8 8], @block_matching_process);
        ind=1;
        for f= 1:8:size(I2,1)
            for j =1:8:size(I2,2)
                quiver(j+4,f+4,motion_vectors(ind,2)-j,motion_vectors(ind,1)-f,'LineWidth',2);
                ind = ind+1;
            end
        end
        hold off
        motion_vectors;
        mseM=mean(msev)
    end

function errors = block_matching_process(block)
    global motion_vectors;
    global actual_positions;
    global msev;
    
    grid_size = block.imageSize ./ block.blockSize;
    grid_position = (block.location-1)./block.blockSize;
    list_index = grid_position(1) * grid_size(2) + grid_position(2) + 1;
    
    [position, errors, minimum_mse] = block_matching(block);
    msev=[msev minimum_mse];
    motion_vectors(list_index, :) = position;
    actual_positions(list_index, :) = block.location;
    
