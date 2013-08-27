function [ words ] = readWordsInFile( filename )
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
    words = cell(2,1);
    
    buf = fgetl(fid);
    i = 0;
    while ischar(buf)
        i = i + 1;
        if length(words) < i
            words = resizeCellArray(words, 1.4);
        end
        
        words(i,1) = textscan(buf, '%q');
        buf = fgetl(fid);
    end
    words = words(1:i);
    
    fclose(fid);
end

function new = resizeCellArray(old, factor)
    newsize = floor(length(old)*factor);
    
    new = cell(newsize, 1);
    new(1:length(old)) = old;
end