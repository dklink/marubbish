function [t, z_balance] = get_growth_balance_depth(particle, t_start, t_end)
    t = datetime(year(t_start), month(t_start), day(t_start), 0, 0, 0):days(1): ...
        datetime(year(t_end), month(t_end), day(t_end), 0, 0, 0);
    lat = particle.lat;
    lon = particle.lon;

    lat_range = [lat, lat];
    lon_range = [lon, lon];
    z_range = [0, 1e9];
    t_range = [t(1), t(end)];

    S = load_4d_hyperslab(Paths.salinity, 'salinity', lon_range, lat_range, z_range, t_range);
    S.data = mean(S.data, 4, 'omitnan');
    S.time = S.time(1);
    T = load_4d_hyperslab(Paths.temperature, 'water_temp', lon_range, lat_range, z_range, t_range);
    T.data = mean(T.data, 4, 'omitnan');
    T.time = T.time(1);
    CHL = load_3d_hyperslab(Paths.chlorophyll, 'chlor_a', lon_range, lat_range, t_range);
    CHL.data = mean(CHL.data, 4, 'omitnan');
    CHL.time = CHL.time(1);  % for now, let's just use yearly averages, to smooth nans
    daily_ave_I_surf = get_daily_mean_surface_PAR(lat, lon, t(1), t(end));  % daily average I_surf
    z_balance = zeros(1, length(t));
    for i=1:length(t)
        z_balance(i) = find_flux_zero(particle, daily_ave_I_surf(i), CHL, S, T, datenum(t(i)));
    end
end

function z_balance = find_flux_zero(particle, I_surf, CHL, S, T, t)
    z_balance = fzero(@flux_vs_z, 0);
    function flux = flux_vs_z(z)
        p = Particle(particle.r_pl, particle.rho_pl, 0, particle.lat, particle.lon, z);
        S_z = S.select(p.lat, p.lon, p.z, t);
        T_z = T.select(p.lat, p.lon, p.z, t);
        chl_surf = CHL.select(p.lat, p.lon, 0, t);
        chl_z = chl_vs_z_stratified(p.z, chl_surf);  % mg m^-3
        chl_tot = get_chl_above_z_stratified(p.z, chl_surf); % mg m^-2
        I_z = get_light_at_z(p.z, I_surf, chl_tot);  % average daily light at depth z

        rho_tot = get_seawater_density(S_z, T_z);
        if isnan(rho_tot)
            disp('huh');
        end
        p.update_particle_from_rho_tot(rho_tot);
        
        flux = get_algae_flux_for_particle(p, S_z, T_z, chl_z, I_z);
        if (flux < 0) && (z == 0)
            flux = 0;
        end
    end
end