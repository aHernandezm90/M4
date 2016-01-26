%Load reference image
I  = imread('Dataset/highway/input/in001350.jpg');
I = rgb2gray(I);
%Rotate image so the middle road line is perpendicular to the botton of the
%image
I = imrotate(I,28);
%Isolate a single line
Icropped=I(250:290,190:240);
%Binarize and apply morpoholigal transformations
Icropped = im2bw(Icropped,0.8);
Icropped = imclose (Icropped, strel('disk',3));
%Compute Hough transform
BW = edge(Icropped,'canny');
[H,T,R] = hough(BW);
%Compute the peaks of Hough transform to get the lines
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',23);
%Plot resluts
figure, imshow(Icropped), hold on
max_len = 0;
for k = 1:length(lines)
   if (lines(k).theta == 0)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

       % Determine the endpoints of the longest line segment
       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
   end
end
%We establish the length of a single line in 3 meters
lengthLine = 3;
%We calculate how many meters corresponds to a single pixel
lengthxPixel = lengthLine/max_len;
disp(strcat('Meters per pixel: ',mat2str(lengthxPixel)));
