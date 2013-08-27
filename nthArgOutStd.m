function [ y ] = nthArgOutStd( fun, nth, varargin)
    ret = cell(nargout(fun), 1);
    [ ret{:} ] = fun(varargin{:});
    y = ret{nth};
end

