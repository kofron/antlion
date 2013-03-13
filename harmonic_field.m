function [ bz, bx, by ] = harmonic_field( x, y, z, bkg, scale, polarity )
%GAUSSIAN_FIELD Contribution from a gaussian magnetic field centered at z0
%   For an axisymmetric contribution from a gaussian shape
%   whose mean is z0, the strength is 'depth', polarity is 'polarity',
%   and whose standard deviation is sqrt(scale/2).  del*B is zero
%   everywhere:
%       Bx = -polarity*z*depth*x/scale*exp(-z^2/scale)
%       By = -polarity*z*depth*y/scale*exp(-z^2/scale)
%       Bz = depth*exp(-z^2/scale);
    bx = -polarity/scale*(x.*z);
    by = -polarity/scale*(y.*z);
    bz = bkg + polarity/scale*(z.^2);
end

