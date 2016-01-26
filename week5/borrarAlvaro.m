I  = imread('Dataset/highway/input/in001350.jpg');
I = rgb2gray(I);
I = imrotate(I,28);
Icropped=I(250:290,190:240);
Icropped = im2bw(Icropped,0.8);
Icropped = imclose (Icropped, strel('disk',3));
BW = edge(Icropped,'canny');
[H,T,R] = hough(BW);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',23);
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
lengthLine = 3;
lengthxPixel = lengthLine/max_len;
