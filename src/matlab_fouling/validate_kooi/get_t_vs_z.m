function [t, z, meta] = get_t_vs_z(num_days, dt_hours, particle)
    % simulate vertical movement for a particle in the North Pacific
    % num_days is length of simulation (days)
    % dt_hours is timestep (hours)
    % returns: [t, z, meta] ([seconds, meters, see meta definition below])

    p = particle;

    dt = constants.seconds_per_hour*dt_hours;
    t = 1:dt:num_days*constants.seconds_per_day;
    z = zeros(1, length(t));
    rho = zeros(1, length(t));
    coll = zeros(1, length(t));
    growth = zeros(1, length(t));
    mort = zeros(1, length(t));
    resp = zeros(1, length(t));
    r_tot = zeros(1, length(t));
    settling_v = zeros(1, length(t));
    A = zeros(1, length(t));

    chl_surf_np = kooi_constants.chl_surf_np;
    chl_ave_np = kooi_constants.chl_ave_np;
    z(1) = p.z;
    rho(1) = p.rho_tot;
    for i=2:length(t)
        I_surf = I_vs_time(t(i));
        T_z = T_vs_z(p.z);
        I_z = get_light_at_z(p.z, I_surf, chl_ave_np);
        S_z = get_S(t, p.lat, p.lon, p.z);
        chl_z = get_chl_at_z(p.z, chl_surf_np);
        
        dAdt = get_algae_flux_for_particle(p, S_z, T_z, chl_z, I_z);
        p.A = p.A + dAdt * dt;

        % this approximates the position function
        V_s = get_settling_velocity(p, S_z, T_z);
        new_z = p.z + V_s * dt;
        if new_z < 0  % constrain to surface
            new_z = 0;
        end
        
        p.z = new_z;
        z(i) = new_z;
        rho(i) = p.rho_tot;
        coll(i) = get_algae_collisions(p, S_z, T_z, chl_z, I_z);
        growth(i) = get_algae_growth(p, T_z, I_z);
        mort(i) = get_algae_mortality(p);
        resp(i) = get_algae_respiration(p, T_z);
        r_tot(i) = p.r_tot;
        settling_v(i) = V_s;
        A(i) = p.A;

    end
    
    % collect and return many properties in timeseries for investigations
    meta = {rho coll growth mort resp r_tot settling_v A};
end