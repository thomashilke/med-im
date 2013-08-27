function [ c, r ] = fitACircle( x, y, cInit, rInit )
    err = @(v) sum((sqrt((v(1)-x).^2 + (v(2)-y).^2) - v(3)).^2);
    res = fminsearch(err, [cInit, rInit]);
    c = res(1:2);
    r = res(3);
end

