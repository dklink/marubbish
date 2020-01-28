function D_star = dimensionless_particle_diameter (particle, S, T)
    % DIMENSIONLESS_PARTICLE_DIAMETER: kooi 2017 eq. 4
    % particle: particle for which to calculate
    % S: salinity at particle (g kg^-1)
    % T: temperature at particle (Celsius)
    % return: dimensionless particle diameter (m)
    rho_tot = particle.rho_tot; % kg m^-3
    rho_sw = get_seawater_density(S, T, particle.lat, particle.lon, particle.z); % kg m^-3
    g = constants.g; % m s^-2
    D_n = particle.D_n;  % equivalent spherical particle diameter
    nu_sw = kinematic_viscosity_seawater(S, T, rho_sw); % m^2 s^-1

    D_star = abs(rho_tot - rho_sw) * g * D_n^3 / (rho_sw * nu_sw^2);
end