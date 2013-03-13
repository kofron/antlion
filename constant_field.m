function [ bz, bx, by ] = constant_field( Bx, By, Bz )
%CONSTANT_FIELD Just a constant vector field pointing in hat(bx,by,bz).
%   constant_field(bx,by,bz) just returns [bx,by,bz].
    bx = Bx;
    by = By;
    bz = Bz;
end

