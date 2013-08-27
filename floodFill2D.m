function J = floodFill2D(I, x, y, levels)
JVisited = false(size(I));
JNext = false(size(I));

P = (I >= levels(1) & I <= levels(2));

if ~P(x,y)
   disp('Warning: seed level is different from seed-point level'),
    
   % find the nearest point in I(:,:,z) having the required level.
   [rowd, cold] = ind2sub(size(I), find(P));
   ddist = sqrt((x-rowd).^2 + (y-cold).^2) ;
   [~, id] =  min(ddist);
   x = rowd(id(1));
   y = cold(id(1));
end

% Point neibourhood definition
neigb = [-1  0; ...
          1  0; ...
          0 -1; ...
          0  1];

%% Process the next list until empty

% algorithm initialisation
JNext(x, y) = true;
nextList = find(JNext);

while ~isempty(nextList)
    [x, y] = ind2sub(size(JNext), nextList);
    for idx = 1:length(x)
        for j = 1:4
            % Calculate the neighbour coordinate
            xn = x(idx) + neigb(j,1);
            yn = y(idx) + neigb(j,2);

            % Check if neighbour is inside or outside the image
            isInside = (xn >= 1) ...
                    && (yn >= 1) ...
                    && (xn <= size(I, 1)) ...
                    && (yn <= size(I, 2));

            % Add neighbor if inside and not already part of the segmented area
            if  isInside ...
                && P(xn, yn) ...
                && ~JVisited(xn, yn)
                JNext(xn, yn) = true;
            end
        end
        JVisited(x(idx),y(idx)) = true;
        JNext(x(idx),y(idx)) = false;
    end
    nextList = find(JNext);
end

J = JVisited;
