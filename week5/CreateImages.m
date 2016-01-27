%CREATEIMAGES Summary of this function goes here
%   Detailed explanation goes here

train = vision.VideoFileReader('Dataset/custom/input.avi');
i=1000;
while ~isDone(train)
    %1.Actual frame
    frame = train.step();
    imwrite(frame,strcat('Dataset/custom/images/in000',num2str(i),'.jpg'));
    i=i+1;
end



