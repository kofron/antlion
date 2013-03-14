function res = ele( M )
%ELE Summary of this function goes here
%   Detailed explanation goes here
    [~, e] = ellipke(M);
    res = e;
end

