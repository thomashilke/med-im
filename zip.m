function [ zippedCell ] = zip( cell1, cell2 )
    zippedCell = cell(length(cell1), 1);
    for i = 1:length(cell1)
        zippedCell{i} = {cell1{i}, cell2{i}};
    end
end

