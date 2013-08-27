function [ conn ] = connectedComponants( adjMatrix )
    conn = cell(0,1);
    visited = false(size(adjMatrix, 1), 1);
    finish = false;
    while ~finish
        next = find(visited == false, 1, 'first');
        if ~isempty(next)
            comp = [];
            stack = next;
            while ~isempty(stack)
                current = stack(end);
                visited(current) = true;
                comp = [comp, current];
                stack(end) = [];
                adj = getAdjacentVertices(current, adjMatrix);
                stack = unique([stack, adj(~visited(adj))]);
            end
            conn{end + 1} = comp;
        else
            finish = true;
        end
    end
end

function adj = getAdjacentVertices(i, adjMatrix)
    adj = find(adjMatrix(i, :));
end