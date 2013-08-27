function [ diff, comm ] = structDiff( structLeft, structRight )
% diff contains the fields which are not on the right side

    if ~isstruct(structLeft) || ~isstruct(structRight)
        error('structDiff() - both arguments must be structs.');
    end

    diff = struct();
    comm = struct();
    
    leftFields = fieldnames(structLeft);
    rightFields = fieldnames(structRight);
    
    delta = ismember(leftFields, rightFields);

    diff = copyFields(diff, structLeft, leftFields(~delta));
    
    for i = find(delta)
        if isstruct(structLeft.(leftFields{i})) 
            
        else
            if ~isequal(structLeft.(leftFields{i}), structRight.(leftFields{i}))
                comm.(leftFields{i}) = structRight.(leftFields{i});
            end
        end
    end
end

function a = copyFields(a, b, fields)
    for i = 1:length(fields)
        a.(fields{i}) = b.(fields{i});
    end
end