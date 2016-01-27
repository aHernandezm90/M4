function [ output ] = Task2Train( params )
%TASK2TRAIN Summary of this function goes here
%   Detailed explanation goes here


%Get an image to train
train = vision.VideoFileReader(params.videoInput);
frame = train.step();

%Select Points
figure,imshow(frame), hold on
[x,y]=ginput(1);
p1=[x,y,1]; % coord. homogènies
plot(p1(1),p1(2),'bo');
[x,y]=ginput(1);
p2=[x,y,1]; % coord. homogènies
plot([p1(1),p2(1)],[p1(2),p2(2)],'bo-');
[x,y]=ginput(1);
p3=[x,y,1]; % coord. homogènies
plot(p3(1),p3(2),'bo');
[x,y]=ginput(1);
p4=[x,y,1]; % coord. homogènies
plot([p3(1),p4(1)],[p3(2),p4(2)],'bo-');
[x,y]=ginput(1);
p5=[x,y,1]; % coord. homogènies
plot([p3(1),p4(1)],[p3(2),p4(2)],'bo-');
[x,y]=ginput(1);
p6=[x,y,1]; % coord. homogènies
plot([p3(1),p4(1)],[p3(2),p4(2)],'bo-');

l12=cross(p1,p2);
l34=cross(p3,p4);
c=cross(l12,l34);
v=c/c(3);

plot([p2(1),c(1)],[p2(2),c(2)],'b:');
plot([p3(1),c(1)],[p3(2),c(2)],'b:');
plot([c(1),c(1)],[c(2),c(2)],'r+','MarkerSize',10);

%Matrix to project
H= projective2d(transpose([1 -v(1)/v(2) 0; 0 1 0; 0 -1/v(2) 1]));

%Project Image
[imOut, ref] = imwarp(frame, H);


realx = [p5(1) p6(1)];
realy = [p5(2) p6(2)];

[homx,homy] = transformPointsForward(H, realx, realy);
%DistHom - distancia en la proyeccion equivale a 5m
disthom = sqrt((homx(1)-homx(2))^2 + (homy(1)-homy(2))^2)
imshow(imOut);
output = [];
end

