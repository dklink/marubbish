function Beta_S = shear_encounter_rate(particle)
%SHEAR_ENCOUNTER_RATE kooi eq. 14
%   particle: the particle
%   return: encounter rate due to shear (m^3 s^-1)
    r_tot = particle.r_tot;
    r_A = kooi_constants.r_A;
    gamma = kooi_constants.gamma; % s^-1
    Beta_S = 1.3 * gamma * (r_tot + r_A).^3;  % advective shear kernel rate (m^3 s^-1)
end

