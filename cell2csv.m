function [  ] = cell2csv( filename, cellArray, fieldSeparator, quoteChar )
    validateattributes(cellArray, {'cell'}, {'2d'});
    if ~exist('fieldSeparator', 'var')
        fieldSeparator = ',';
    end
    if ~exist('quoteChar', 'var')
        quoteChar = '';
    end
    
    
    file = fopen(filename, 'w');
    
    datasetSizes = size(cellArray);
    for iRow = 1:datasetSizes(1)
        for iCol = 1:datasetSizes(2)
            element = cellArray{iRow, iCol};
            if isnumeric(element) || islogical(element)
                % This will avoid arrays of values, as well as empty
                % arrays:
                if isscalar(element)
                    fprintf(file, '%g', element);
                end
            elseif ischar(element)
                if isvector(element)
                    if ~isempty(strfind(element, fieldSeparator))
                        warning(['Element ' num2str(iRow) ', ' num2str(iCol) ...
                                 ' may contain the field separator character.']);
                    end
                    %TODO: protect quote-char in element if present.
                    fprintf(file, [quoteChar '%s' quoteChar], element);
                end
            else
                warning(['Element ' num2str(iRow) ', ' num2str(iCol) ...
                         ' was silently omitted,' ... 
                         ' because it''s a ' class(element)]);
            end
            if iCol < datasetSizes(2)
                fprintf(file, fieldSeparator);
            end
        end
        fprintf(file, '\n');
    end
    
    fclose(file);
end

