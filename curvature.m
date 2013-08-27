function [ k ] = curvature( x, y )
    k = [];
    if length(x) > 2
        k = zeros(length(x)-2, 1);
        for i = 2:(length(x)-1)
            k(i-1) = 4.*((x(i+1) - x(i-1))*(y(i+1) - 2*y(i) + y(i-1)) - ...
                      (y(i+1) - y(i-1))*(x(i+1) - 2*x(i) + x(i-1))) ...
                     /((x(i+1) - x(i-1))^2+(y(i+1) - y(i-1))^2)^(3./2.);
        end    
    end
end

