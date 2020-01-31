function dzdt = odefcn (t, z, p_initial, dt)
    p.z = z;
    
    persistent p;
    
    if t==0
        p = p_initial;
    end
    chl_surf = .05;
    chl_ave = .151;
    
    I_surf = I_vs_time(t);
    T_z = T_vs_z(p.z);
    I_z = get_light_at_z(p.z, I_surf, chl_ave);
    S_z = S_vs_z(p.z);
    p.A = p.A + dt*get_algae_flux_for_particle(p, S_z, T_z, chl_surf, I_z);
    dzdt = get_settling_velocity(p, S_z, T_z);
    
    if (p.z >= 0) && (dzdt < 0) % particles can't fly
        dzdt = 0;
    end
    
end