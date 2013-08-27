function [ value ] = getStructField( var, fieldPath )
    value = var;
    if ischar(fieldPath)
        if ~isfield(value, fieldPath)
           exception = MException('getStructField:InvalidFieldName', ['var has no field named "' fieldPath '"']);
           throw(exception);
        end
        value = value.(fieldPath);
    elseif iscell(fieldPath) && ~isempty(fieldPath)
        while ~isempty(fieldPath)
            if ~isfield(value, fieldPath{1})
                exception = MException('getStructField:InvalidFieldName', ['var has no field named "' fieldPath{1} '"']);
                throw(exception);
            end
            value = value.(fieldPath{1});
            fieldPath(1) = [];
        end
    end
end

