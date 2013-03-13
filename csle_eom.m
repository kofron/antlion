function drs = csle_eom( ~, rs, bs )
%csle_eom evaluates the equations of motion in the cyclotron scaled lorentz
%   force law.
    xs = rs(1:3);
    vs = rs(4:6);
    f = csle(xs(1),xs(2),xs(3),vs(1),vs(2),vs(3),bs);
    drs = [rs(4:6);f'];
end

