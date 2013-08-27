function [ k, varargout ] = smoothedCurvature( x, y, kernel )
    k = [];
    kernelSides = (length(kernel)-1)/2;

    if numel(x) > (kernelSides+1)
        %% Pad parametrisations
        if abs(x(1) - x(end)) < 1e-6 && abs(y(1) - y(end)) < 1e-6
            x = [x(end-kernelSides-1:end-1), x, x(2:kernelSides+1)];
            y = [y(end-kernelSides-1:end-1), y, y(2:kernelSides+1)];
        else
            x = [x(1) + (kernelSides:-1:1)*(x(1)-x(2)), x, x(end) + (1:kernelSides)*(x(end)-x(end-1))];
            y = [y(1) + (kernelSides:-1:1)*(y(1)-y(2)), y, y(end) + (1:kernelSides)*(y(end)-y(end-1))];
        end
        
        %% Smooth the line
        x = conv(x, kernel, 'valid');
        y = conv(y, kernel, 'valid');
        
        %% Return the smoothed lines
        if nargout == 3
            varargout{1} = x;
            varargout{2} = y;
        end
        
        %% compute the curvature
        k = curvature(x,y);

    else
        varargout = cell(nargout, 1);
    end
end

