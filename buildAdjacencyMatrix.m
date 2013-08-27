function [ adjMatrix ] = buildAdjacencyMatrix( vertices, connectivityRelationHandle )
    adjMatrix = false(length(vertices));
    for i = 1:(length(vertices)-1)
        for j = (i+1):length(vertices)
            if connectivityRelationHandle(vertices{i}, vertices{j})
                adjMatrix(i,j) = true;
                adjMatrix(j,i) = true;
            end
        end
    end
end

