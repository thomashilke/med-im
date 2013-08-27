function fileList = getDicomFilesFullNames( rootSearch, validateFilename )
% getDicomFilesFullNames    iterate recursively in the folder rootSearch,
%                           and return a cell array filled with each
%                           regular file it has encountered.
%
%   The function name 'getDicomFilesFullNames' is misleading, since it has
%   nothing to do with dicom files: it return any file which is not a
%   directory. But it was name that way, because it is used to retrieve all
%   the dicom files in a folder hierarchy.
%
%   Input Arguments:
%
%   rootSearch          is the character string of a directory to search
%                       recursively.
%   validateFilename    is a handle to a function which takes a filename as
%                       input argument. If this function evaluate to true,
%                       then the filename is appended to the list of
%                       returned files. Passing no validateFunction
%                       argument is equavalent to passing the @(x) true;
%                       function.
%
%   Output Arguments:
%
%   fileList        is a cell array where each element is the character
%                   string of the path relative to rootSearch of each
%                   regular files encountered in the rootSearch folder.

    if ~exist('validateFilename', 'var') || ~isa(validateFilename, 'function_handle')
        validateFilename = @validateDicomFile;
    end
    
    listing = dir(rootSearch);
    fileList = {};
    for i = 1:length(listing)
        if listing(i).isdir == 0
            if validateFilename(listing(i).name, rootSearch)
                fileList{end+1} = fullfile(rootSearch, listing(i).name);
            end
        elseif isempty(regexp(listing(i).name, '^\.{1,2}$', 'once'))
            subDirectory = fullfile(rootSearch,listing(i).name);
            subDirectoryFileList = getDicomFilesFullNames(subDirectory, validateFilename);
            fileList = [fileList {subDirectoryFileList}];
        end
    end
    fileList = fileList';
end


function isDicom = validateDicomFile(filename, path)
    fullfile(path, filename);
    fid = fopen(fullfile(path, filename));
    if fid > 0
        fseek(fid, 128, 'bof');
        isDicom = strcmp(fread(fid, 4, '*char'), ['D';'I';'C';'M']);
        fclose(fid);
    else
        isDicom = false;
    end
end