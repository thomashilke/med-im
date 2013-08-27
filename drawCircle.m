function drawCircle( c, r, n, varargin )
    plot(c(1)+r*sin(linspace(0, 2*pi, n)), c(2)+r*cos(linspace(0, 2*pi, n)), varargin{:});
end

