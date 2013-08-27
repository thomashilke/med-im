function [ flatCharCell ] = prepareCellArrayForDisplay( cellArray )
    validateattributes(cellArray, {'cell'}, {'2d'});

    dims = size(cellArray);
    flatCharCell = cell(dims);
    
    for i = 1:dims(1)
        for j = 1:dims(2)
            flatCharCell{i,j} = convertToString(cellArray{i,j});
        end
    end
end

function [ str ] = convertToString( var )
    cellType = class(var);
    str = '';
    
    switch cellType
        case 'struct'
            fields = fieldnames(var);
            for i = 1:length(fields)
                str = [str ' ' convertToString(var.(fields{i}))];
            end
        case 'char'
            str = var;
        case 'double'
            str = num2str(var, '%g');
        case 'single'
            str = num2str(var, '%g');
        case 'int8'
            str = num2str(var, '%i');
        case 'int16'
            str = num2str(var, '%i');
        case 'int32'
            str = num2str(var, '%i');
        case 'int64'
            str = num2str(var, '%i');
        case 'uint8'
            str = num2str(var, '%u');
        case 'uint16'
            str = num2str(var, '%u');
        case 'uint32'
            str = num2str(var, '%u');
        case 'uint64'
            str = num2str(var, '%u');
        case 'logical'
            if (var); str = 'true'; else str = 'false'; end
    end
end