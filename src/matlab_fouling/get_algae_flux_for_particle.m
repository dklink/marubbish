function dAdt = get_algae_flux_for_particle(particle, S, T, chl, I)
% get_algae_flux_for_particle: returns the time derivative of the number of
%   algal cells attached to a particle.  Kooi 2017, eq. 11.
% particle: the particle in question
% S: salinity at the particle's location (g kg^-1)
% T: temperature at the particle's location (Celsius)
% chl: ambient chlorophyll concentration at the particle's location (mg m^-3)
% I: light intensity at the particle's location (mol quanta m^-2 s^-1)
% return: time derivative of number of algal cells attached to particle (# algal cells s^-1)
    dAdt = get_algae_collisions(particle, S, T, chl, I) + ...
           get_algae_growth(particle, T, I) + ...
           get_algae_mortality(particle) + ...
           get_algae_respiration(particle, T);
end
