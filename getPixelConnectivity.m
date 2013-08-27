function [ cImage ] = getPixelConnectivity( bwImage )
    kernel = ones(3,3);
    kernel(2,2) = 0;
    neighbours = conv2(double(bwImage), kernel, 'same');
    cImage = neighbours().*bwImage;
end

