function [position, errors, minimum_mse] = block_matching(block)

    global I1;                          
    global N;

    
  minimum_mse = inf;
  minI=block.location(1)-12;
  maxI=block.location(1)+12;
  minI(minI< 1)=1;
  maxI(maxI> size(I1,1)-7 )=size(I1,1)-7;
  minJ=block.location(2)-12;
  maxJ=block.location(2)+12;
  minJ(minJ< 1)=1;
  maxJ(maxJ> size(I1,2)-7 )=size(I1,2)-7;

  for i= minI:N:maxI
    for j = minJ:N:maxJ
          err = mse(block,[i j]);
          if err < minimum_mse
            minimum_mse=err;
            position(1)=i;
            position(2)=j;
          end
    end
   end
    
    errors = block.data-I1(position(1):position(1)+7,position(2):position(2)+7);

end

