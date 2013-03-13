function sim = ode23t_csle( pitch_angle, t_max, mode )
    tic;

    sim = struct();
    b = [];
    switch mode
        case 'constant_field'
            b = @(xs,ys,zs) constant_field(0,0,1);
        case 'bathtub_trap'
            b = @(xs,ys,zs) bathtub_field(xs,ys,zs,-100,100,1.0,50,1.0e-2,1.0);
        case 'gaussian_trap'
            b = @(xs,ys,zs) gaussian_field(xs,ys,zs,0,1.0,50,1.0e-2,-1.0);
        otherwise
            error('mode not understood: try (constant_field, bathtub_trap, or gaussian_trap)');
    end 

    v_perp = cos(pitch_angle);
    v_par = sin(pitch_angle);
    tgt = @(t,r) -1.0*csle_eom(t,r,b);
    t_lim = [0 t_max];
    
    init_cond = [0 1 0 v_perp 0 v_par];
    options = odeset('RelTol', 1.0e-8);
    [t, x] = ode23t(tgt, t_lim, init_cond, options);
    sim.t = t;
    sim.rawpos = x;
    [th, rh, zd] = cart2pol(x(:,1), x(:,2), x(:,3));
    sim.th = th;
    sim.rh = rh;
    sim.zd = zd;
    
    sim.v_zd = x(:,6);
    sim.v_rh = (2./sim.rh).*(x(:,1).*x(:,4) + x(:,2).*x(:,5));
    
    sim.sample_freq = length(t)/t_max;
    sim.phase_fft = fft(cos(sim.th) + j*sin(sim.th));
    sim.norm_f = (0:(length(sim.phase_fft) - 1))/length(sim.phase_fft);
    sim.rel_f  = 2*pi*sim.norm_f*sim.sample_freq; 

    % barf out elapsed time
    toc;
end