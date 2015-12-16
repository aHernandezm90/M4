function [resultList] = deleteHiddenFiles(listFiles)
%:::deleteHiddenFiles::::::::::::::::::::::::::::::::::::::::::::::::::::::
%Given a file list, deletes from it the ones that corresponds to hidden 
%system files for UNIX based systems: .,.. and .DS_Store
%Input:
%   -listFiles
%Output:
%   -resultList:list of files without hidden ones (if they were).
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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

