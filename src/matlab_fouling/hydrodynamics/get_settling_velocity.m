function V_s = get_settling_velocity (particle, S, T)
% GET_SETTLING_VELOCITY calculate settling velocity for particle
%    Kooi 2017, eq. 2
% particle: the particle in question
% S: salinity of water parcel (g / kg)
% T: temperature of water parcel (degrees C)

% return: settling velocity of the particle (m/s)
    rho_tot = particle.rho_tot;
    rho_sw = get_seawater_density(S, T, particle.lat, particle.lon, particle.z);
    g = constants.g;
    omega_star = dimensionless_settling_velocity(particle, S, T);
    nu_sw = kinematic_viscosity_seawater(S, T);
    V_s = nthroot(((rho_tot - rho_sw)/rho_sw .* g.*omega_star*nu_sw), 3); 
    % note: differs from kooi in a minus, since we use z positive down
    if particle.z <=0
       V_s(V_s < 0) = 0; % constraint on particles at surface
    end
end
