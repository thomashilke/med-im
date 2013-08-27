function [ k ] = gaussianKernel( sigma, sigmaTruncation )
    kernelWidth = 2*floor(sigma*sigmaTruncation)+1;
    k = 1/(sqrt(2*pi)*sigma)*exp(-linspace(-floor(sigma*sigmaTruncation), ...
                                            floor(sigma*sigmaTruncation), ...
                                            kernelWidth)'.^2/(2*sigma^2));
end

