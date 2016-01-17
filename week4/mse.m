function error = mse(block, I1_block_position)
    global I1;

    y = I1_block_position(1);
    x = I1_block_position(2);

    diff = (double(block.data) - double(I1(y:y+7, x:x+7))).^2;

    error = sum(diff(:)) / numel(block.data);
end
