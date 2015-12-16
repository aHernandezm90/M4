function [resultList] = deleteHiddenFiles(listFiles)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
resultList = listFiles;
if(isdir(resultList(1).name))
    if(isdir(resultList(2).name))
        if(strcmp(resultList(3).name,'.DS_Store'))
            resultList(3) = [];
        end
        resultList(2) = [];
    end
    resultList(1) = [];
end

end

