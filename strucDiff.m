function strucdiff(s1, s2, s1str, s2str)
% Calling syntax: >> strucdiff(s1, s2)

if nargin<=2
    s1str = inputname(1);
    s2str = inputname(2);
end

if isstruct(s1) && isstruct(s2)
    f1 = fieldnames(s1);
    f2 = fieldnames(s2);
    g1 = setdiff(f2,f1);
    for k=1:length(g1)
        fprintf('<%s.%s> is missing.\n', s1str, g1{k});
    end
    g2 = setdiff(f1,f2);
    for k=1:length(g2)
        fprintf('<%s.%s> is missing.\n', s2str, g2{k});
    end
    fcommon = intersect(f1,f2);
    for k=1:length(fcommon)
        fk = fcommon{k};
        strucdiff(s1.(fk), s2.(fk), ...
                  [s1str '.' fk], [s2str '.' fk])
    end
elseif ~isstruct(s1) && isstruct(s2)
    fprintf('<%s> is not struct but <%s> is.\n', s1str, s2str);
elseif isstruct(s1) && ~isstruct(s2)
    fprintf('<%s> is struct but <%s> is not.\n', s1str, s2str);
elseif ~isequal(s1, s2)
    fprintf('<%s> and <%s> differs.\n', s1str, s2str);
end
