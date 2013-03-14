function [ Bz, Bx, By ] = finite_sol_field( ni, L, a, x, y, z, z0 )
%FINITE_SOL_FIELD field from a finite solenoid as detailed in NASA
%technical note D-465, "The Magnetic Field of a Finite Solenoid"
    zl = z-z0;

    % zeta
    zt_p = zl - L/2;
    zt_m = zl + L/2;
    
    % convert to cylindricals
    [th, rh] = cart2pol(x,y,zl);


    % mu naught
    mu0 = 4*pi*1e-7;
    
    if rh == 0
        b_rh = 0;
        b_z_t = @(zt) zt/sqrt(zt^2 + a^2); 
        b_z = mu0*ni/(4*L)*(b_z_t(zt_p) - b_z_t(zt_m));
    else
        % h^2 and k^2
        h = sqrt(4*a*rh/(a + rh)^2);
        hsq = 4*a*rh/(a + rh)^2;
        k = @(zt) sqrt(4*a*rh/((a + rh)^2 + zt^2));
        ksq = @(zt) 4*a*rh/((a + rh)^2 + zt^2);
        
        % complete elliptic integral of the 3rd kind
        cei3 = @(h,k) elliptic3(pi/2, k, h);
        
        b_rh_t = @(zt) (ksq(zt) - 2)/(2*k(zt))*elk(ksq(zt)) + 1/k(zt)*ele(ksq(zt));
        b_rh = mu0*ni/(2*pi*L)*sqrt(a/rh)*(b_rh_t(zt_p) - b_rh_t(zt_m));
        
        b_z_t = @(zt) zt*k(zt)*(elk(ksq(zt)) + (a-rh)/(a+rh)*cei3(hsq,ksq(zt)));
        b_z = mu0*ni/(8*pi*L*sqrt(a*rh))*(b_z_t(zt_p) - b_z_t(zt_m));
    end
    
    Bx = b_rh*cos(th);
    By = b_rh*sin(th);
    Bz = b_z;

end

