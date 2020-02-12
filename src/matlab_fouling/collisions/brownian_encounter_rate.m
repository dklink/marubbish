function Beta_B = brownian_encounter_rate(particle, S, T, r_A)
%BROWNIAN_ENCOUNTER_RATE kooi eq. 14&15
    % particle: the particle
    % S: salinity (g/kg)
    % T: temperature (C)
    % r_A: radius of algae.  Only used for testing.
    % return: brownian encounter rate (m^3 s^-1)
    if (nargin == 3)
        r_A = kooi_constants.r_A;
    end
    r_tot = particle.r_tot;
    mu_sw = dynamic_viscosity_seawater(S, T);
    k = constants.k; % boltzmann constant (m^2 kg s^-2 K^-1)

    D_pl = k * (T + 273.16) ./ (6*pi * mu_sw * r_tot);   % diffusivity of plastic particle (m^2 s^-1)
    D_A = k * (T + 273.16) ./ (6*pi * mu_sw * r_A);      % diffusivity of algae cell (m^2 s^-1)
    
    Beta_B = 4*pi * (D_pl + D_A) .* (r_tot + r_A);  % brownian motion kernel rate (m^3 s^-1)
end

