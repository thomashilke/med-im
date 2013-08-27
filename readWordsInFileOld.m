function [ words ] = readWordsInFileOld( filename )
%readWordsInFile  reads the whitespace separated words on each line of
%                 the text file filename.
%
% Inputs:
%   filename    Path to a text file. Each line should be a list of words
%               separated by whitespaces.
%
% Outputs:
%   words       A one-dimensional cell array where each cell contains a
%               string cell array of the list of words found in the 
%               corresponding line of the file filename. For example, the
%               fifth word on the second line is stored at words{2}{5}.


    fid = fopen(filename);
    words = cell(0,1);
    
    buf = fgetl(fid);
    while ischar(buf)

        
        words(end+1,1) = textscan(buf, '%q');
        buf = fgetl(fid);
    end
    
    fclose(fid);
end