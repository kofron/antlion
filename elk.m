function res = elk( M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [k, ~] = ellipke(M);
    res = k;

end

