function [ bz, bx, by ] = bathtub_field( x, y, z, z0, z1, bkg, scale, depth, polarity )
%GAUSSIAN_FIELD Contribution from a gaussian magnetic field centered at z0
%   For an axisymmetric contribution from a gaussian shape
%   whose mean is z0, the strength is 'depth', polarity is 'polarity',
%   and whose standard deviation is sqrt(scale/2).  del*B is zero
%   everywhere:
%       Bx = -polarity*z*depth*x/scale*exp(-z^2/scale)
%       By = -polarity*z*depth*y/scale*exp(-z^2/scale)
%       Bz = depth*exp(-z^2/scale);
    bx = polarity*depth/scale*(x.*((z-z0).*exp(-(z-z0).^2/scale) +...
                                   (z-z1).*exp(-(z-z1).^2/scale)));
    by = polarity*depth/scale*(y.*((z-z0).*exp(-(z-z0).^2/scale) +...
                                   (z-z1).*exp(-(z-z1).^2/scale)));
    bz = bkg + polarity*depth*(exp(-(z-z0).^2/scale) + exp(-(z-z1).^2/scale));
end

