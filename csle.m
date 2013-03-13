function f = csle( xs, ys, zs, vxs, vys, vzs, bs )
%csle The 'cyclotron scaled' lorentz equation, where units are
%   dimensionless and scaled to the gyroradius, cyclotron frequency,
%   and maximum field strength.
    [Bzs, Bxs, Bys] = bs(xs,ys,zs);
    f = cross([vxs,vys,vzs],[Bxs,Bys,Bzs]);
end

