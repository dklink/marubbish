function D_star = dimensionless_particle_diameter (particle, rho_sw, nu_sw)
    % DIMENSIONLESS_PARTICLE_DIAMETER: kooi 2017 eq. 4
    % particle: particle for which to calculate
    % S: salinity at particle (g kg^-1)
    % T: temperature at particle (Celsius)
    % return: dimensionless particle diameter (m)
    rho_tot = particle.rho_tot; % kg m^-3
    g = constants.g; % m s^-2
    D_n = 2*particle.r_tot;  % equivalent spherical particle diameter

    D_star = abs(rho_tot - rho_sw) .* g .* D_n.^3 / (rho_sw .* nu_sw.^2);
end