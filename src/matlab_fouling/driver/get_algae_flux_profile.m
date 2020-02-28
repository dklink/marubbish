function [flux, z] = get_algae_flux_profile(particle, t)
    % plots a profile of algae flux of a neutrally buoyant particle vs z
    % particle: particle entity
    % t: single day (datetime)
    
    lat_range = [particle.lat, particle.lat];
    lon_range = [particle.lon, particle.lon];
    z_range = [0, 1e9];
    t_range = [t, t];
    % load the forcing to start with
    S = load_4d_hyperslab(Paths.salinity, 'salinity', lon_range, lat_range, z_range, t_range);
    S.data = mean(S.data, 4, 'omitnan');
    S.time = S.time(1);
    T = load_4d_hyperslab(Paths.temperature, 'water_temp', lon_range, lat_range, z_range, t_range);
    T.data = mean(T.data, 4, 'omitnan');
    T.time = T.time(1);
    CHL = load_3d_hyperslab(Paths.chlorophyll, 'chlor_a', lon_range, lat_range, t_range);
    CHL.data = mean(CHL.data, 4, 'omitnan');
    CHL.time = CHL.time(1);  % for now, let's just use yearly averages, to smooth nans
    I_surf = get_daily_mean_surface_PAR(particle.lat, particle.lon, t, t);  % daily average I_surf

    n = 1000;
    z = linspace(0, 200, n);
    flux = zeros(0, n);
    t_num = datenum(t);
    for i=1:length(z)
        p = Particle(particle.r_pl, particle.rho_pl, 0, particle.lat, particle.lon, z(i));
        S_z = S.select(p.lat, p.lon, p.z, t_num);
        T_z = T.select(p.lat, p.lon, p.z, t_num);
        chl_surf = CHL.select(p.lat, p.lon, 0, t_num);
        chl_z = chl_vs_z_stratified(p.z, chl_surf);  % mg m^-3
        chl_tot = get_chl_above_z_stratified(p.z, chl_surf); % mg m^-2
        I_z = get_light_at_z(p.z, I_surf, chl_tot);  % average daily light at depth z

        rho_tot = get_seawater_density(S_z, T_z);
        p.update_particle_from_rho_tot(rho_tot);  % give particle enough algae that it is neutrally buoyant
        flux(i) = get_algae_flux_for_particle(p, S_z, T_z, chl_z, I_z);
    end
    figure; plot(flux, z);
    set(gca, 'ydir', 'reverse');
    [~, min_i] = min(abs(flux));
    xline(0);
    legend(sprintf('z_{balance} = %.2f m', z(min_i)));
    xlabel('algae flux');
    ylabel('depth (m)');
end