function [ low, up ] = poissonianConfidenceInterval(k, confidenceLevel)
    zalpha005 = fzero(@(x) (1-confidenceLevel-erf(x)),0)*sqrt(2);
    low = k.*(1.-1./(9.*k) - zalpha005 ./(3.*sqrt(k))).^3;
    up = (k+1).*(1.-1./(9.*(k+1)) + zalpha005 ./(3.*sqrt(k+1))).^3;
end