function [ range ] = buildRange(year, month, dayRange)
    validateattributes(year, {'numeric'}, {'integer', 'scalar', '>', 0});
    validateattributes(month, {'char'}, {'vector', 'numel', 3})

    monthDict = struct('jan', [1,  31], 'feb', [2,  28], 'mar', [3,  31], ...
                       'apr', [4,  30], 'may', [5,  31], 'jun', [6,  30], ...
                       'jul', [7,  31], 'aug', [8,  31], 'sep', [9,  30], ...
                       'oct', [10, 31], 'nov', [11, 30], 'dec', [12, 31]);
    if mod(year, 400) == 0
        monthDict.feb(2) = 29;
    elseif mod(year, 100) == 0
        monthDict.feb(2) = 28;
    elseif mod(year, 4) == 0
        monthDict.feb(2) = 29;
    else
        monthDict.feb(2) = 28;
    end
    
    if exist('dayRange', 'var')
        validateattributes(dayRange, {'numeric'}, {'integer', 'vector', 'numel', 2, '<', 32, '>', 0});
        if dayRange(2) > monthDict.(month)(2)
            error('buildRange: high day bound incompatible with selected month.');
        elseif dayRange(1) > dayRange(2)
            error('buildRange: low daybound higher than high day bound.');
        elseif dayRange(1) == dayRange(2)
            dayRange = dayRange(1);
        end
    else
        dayRange = [1, monthDict.(month)(2)];
    end
    
    if length(dayRange) == 2
        range = [    num2str(year) num2str(monthDict.(month)(1), '%02u') num2str(dayRange(1), '%02u') ...
                 '-' num2str(year) num2str(monthDict.(month)(1), '%02u') num2str(dayRange(2), '%02u')];
    else
        range = [num2str(year) num2str(monthDict.(month)(1), '%02u') num2str(dayRange, '%02u')];
    end
end
