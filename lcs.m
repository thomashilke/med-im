function [ common ] = lcs( s1, s2, varargin )
% lcs   Finds the common subsequences of s1 and s2
%
%   lcs(s1, s2) search for the longest common subsequence of the two
%   sequences s1 and s2. If their is more than one longest subsequence, 

    C = buildMat(s1, s2);
    common = backtrack(C, s1, s2, length(s1), length(s2));
end

function C = buildMat(s1, s2)
    C = zeros(length(s1) + 1, length(s2) + 1, 'int16');
    for i = 1:length(s1)
        for j = 1:length(s2)
            if s1(i) == s2(j)
                C(i+1,j+1) = C(i-1+1, j-1+1) + 1;
            else
                C(i+1,j+1) = max(C(i+1,j-1+1), C(i-1+1, j+1));
            end
        end
    end
end

function s = backtrack(C, s1, s2, i, j)
    s = cell(2,1);
    if i == 0 || j == 0
        return;
    elseif s1(i) == s2(j)
        t = backtrack(C, s1,s2, i-1, j-1);
        s{1} = [t{1}, i];
        s{2} = [t{2}, j];
    else
        if C(i+1, j-1+1) > C(i-1+1, j+1)
            s = backtrack(C, s1,s2,i, j-1);
        else
            s = backtrack(C, s1,s2, i-1,j);
        end
    end
end