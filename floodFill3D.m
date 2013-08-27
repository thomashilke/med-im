function J = floodFill3D(I, x, y, z, predicate)
    %% Declare the working variables
    JVisited = false(size(I));
    JNext = false(size(I));

    %% Create the predicate matrix 
    if isa(predicate, 'function_handle')
        P = predicate(I);
    elseif isa(predicate, 'numeric') && length(predicate) == 2
        P = (I >= predicate(1) & I <= predicate(2));
    else
        error('floodFill3Dp: predicate must be a function handle or an array of length 2.');
    end

    %% Find the initial point if the user input is not satisfactory
    if ~P(x,y,z)
       disp('Warning: seed does not satisfy the predicate'),

       % find the nearest point in I(:,:,z) having the required level.
       [rowd, cold] = ind2sub(size(I), find(P(:,:,z)));
       ddist = sqrt((x-rowd).^2 + (y-cold).^2) ;
       [~, id] =  min(ddist);
       x = rowd(id(1));
       y = cold(id(1));
    end

    % Point neibourhood definition
    neigb = [-1  0  0; ...
              1  0  0; ...
              0 -1  0; ...
              0  1  0; ...
              0  0 -1; ...
              0  0  1];

    %% Process the next list until empty

    % Algorithm initialisation:
    JNext(x, y, z) = true;
    nextList = find(JNext);

    while ~isempty(nextList)
        [x, y, z] = ind2sub(size(JNext), nextList);
        for idx = 1:length(x)
            for j = 1:6
                % Calculate the neighbour coordinate
                xn = x(idx) + neigb(j,1);
                yn = y(idx) + neigb(j,2);
                zn = z(idx) + neigb(j,3);

                % Check if neighbour is inside or outside the image
                isInside = (xn >= 1) ...
                        && (yn >= 1) ...
                        && (zn >= 1) ...
                        && (xn <= size(I, 1)) ...
                        && (yn <= size(I, 2)) ...
                        && (zn <= size(I, 3));

                % Add neighbour if inside and not already part of the segmented area
                if  isInside ...
                    && ~JVisited(xn, yn, zn) ...
                    && P(xn, yn, zn)
                    JNext(xn, yn, zn) = true;
                end
            end
            JVisited(x(idx),y(idx),z(idx)) = true;
            JNext(x(idx),y(idx),z(idx)) = false;
        end
        nextList = find(JNext);
    end
    J = JVisited;
end
