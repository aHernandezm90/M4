mov = avifile('source3.avi','compression','None');
dir = 'Dataset/Traffic/input/in00';
for n=0:1:99

if (n+50)<100
o = '0';

else
o = '';
end
    
    
N = int2str(950+n);
nFoto = [dir,o,N,'.jpg'];



img = imread(nFoto);
fr = im2frame(img);
mov = addframe(mov,fr);
end
mov=close(mov);
