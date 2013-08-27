function [c, r] = findCircleBoundaries(bw, rMin, rMax, devMax, sigma, angle)
% findCirclesBoundaries     Detect the circle and return their parameters.
%   
%   For a black and white 2D image bw, findCircleBoundaries extract the
%   individual segments, select the ones which are candidates to be a
%   circle boundary, based on the regularity of the curvature, the length
%   of the segment, and the min and max radii we are looking for.
%
%   Input parameters:
%   
%   bw      A 2D black and white image where we are expecting some circle
%           boundaries. This is usually the result of an edge detection 
%           filter, like the matlab's edge function.
%
%   rMin    A double value. This is the lower bound of the radii selected
%           as circles boundaries candidates. However, the resulting
%           circle's radius may be lower, since rMin is used apriori of the
%           fitting procedure. (Default: 0.1*min(size(bw))/2. )
%
%   rMax    A double value. This is the upper bound of the radii selected
%           as circles boundaries candidates. However, the resulting
%           circle's radius may be higher, since rMax is used apriori of 
%           the fitting procedure. (Default: 0.9*min(size(bw))/2.)
%
%   devMax  A double value. This is the upper bound of the sample standard
%           deviation of the segments selected a circle's boundaries
%           candidates. (Default: 0.02)
%
%   sigma   A double value. This is the sigma of the gaussian used to
%           prefilter the segments, before curvature estimation. Sigma is 
%           in units of the bw matrix indices. (Default: 4)
%
%   angle   A double value. This is the minimal angle swept by the segment
%           around the corresponding circle's center to be selected to be a
%           circle's boundary candidate. (Default: pi)


%% default argument initialisation
    if ~exist('rMin', 'var')
        rMin = 0.1*min(size(bw))/2.;
    end
    if ~exist('rMax', 'var')
        rMax = 0.9*min(size(bw))/2.;
    end
    if ~exist('devMax', 'var')
        devMax = 0.02;
    end
    if ~exist('sigma', 'var')
        sigma = 4;
    end
    if ~exist('angle', 'var')
        angle = pi;
    end

%% data preparation
    c = cell(0,0);
    r = cell(0,0);

    kMin = 1./rMax;
    kMax = 1./rMin;

    bw = bwmorph(bw, 'thin');
    bw(getPixelConnectivity(bw) > 2) = 0;
    cc = bwconncomp(bw);

%% segment validation and circle detection
    for i = 1:cc.NumObjects
        [x, y] = ind2sub(size(bw), cc.PixelIdxList{i});
        [x, y] = getLineParam(x,y);

        k = smoothedCurvature(x', y', gaussianKernel(sigma,3));
        if sum(k<0) > (length(k)/2)
            k = -k;
        end

        if ~isempty(k)
            d = std(k);
            m = mean(k);

            if    m > kMin ...
               && m < kMax ...
               && d < devMax ...
               && segLength(x,y)*m > angle
                [c{end+1}, r{end+1}] = fitACircle(x, y, mean([x y]), 1/m);
            end
        end
    end
    
%% find similar circles
    adj = buildAdjacencyMatrix(zip(c,r), @(x, y) ((sum(sqrt((x{1}-y{1}).^2)) < 3) && (abs(x{2}-y{2}) < 3)));
    sim = connectedComponants(adj);
    u = cellfun(@(x) x(1), sim);
    
    c = c(u);
    r = r(u);
end

function l = segLength(x, y)
% segLength     length of the segment
%   segLength(x,y) is the length of the segment describe by the two vector
%   of coordinates x and y.

    l = sum(sqrt(diff(x).^2+diff(y).^2));
end