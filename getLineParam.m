function [ x, y ] = getLineParam( x, y )
    pointNumber = length(x);
    if pointNumber == 1
        return;
    end
    adjacencyMatrix = false(pointNumber);
    
    for i = 1:(pointNumber-1)
        for j = (i+1):pointNumber
            if distance(x(i), y(i), x(j), y(j)) == 1
                adjacencyMatrix(i,j) = true;
                adjacencyMatrix(j,i) = true;
            end
        end
    end
    
    endPoints = find(sum(adjacencyMatrix) == 1);
    pointList = zeros(pointNumber, 1);
    isClosed = false;
    if isempty(endPoints)
        isClosed = true;
        pointList(1) = 1;
        neighbours = find(adjacencyMatrix(:, pointList(1)));
        adjacencyMatrix(pointList(1), neighbours(1)) = false;
        adjacencyMatrix(neighbours(1), pointList(1)) = false;
    else
        pointList(1) = endPoints(1);
    end
    
    for i = 2:pointNumber
        adj = find(adjacencyMatrix(:, pointList(i-1)));
        adjacencyMatrix(adj, pointList(i-1)) = false;
        adjacencyMatrix(pointList(i-1), adj) = false;
        pointList(i) = adj;
    end
    
    x = x(pointList);
    y = y(pointList);
    if isClosed == true
        x(end+1) = x(1);
        y(end+1) = y(1);
    end
end

function d = distance( ax, ay, bx, by )
    d = max(abs(ax-bx), abs(ay-by));
end