function Beta_A = get_encounter_kernel_rate(particle, S, T)
%GET_ENCOUNTER_KERNEL_RATE  Kooi 2017 eq. 14-15
%   Detailed explanation goes here
% particle: the particle we're calculating for
% S: salinity at the particle (g kg^-1)
% T: temperature at the particle (Celsius)
    k = constants.k; % boltzmann constant (m^2 kg s^-2 K^-1)
    mu_sw = dynamic_viscosity_seawater(S, T);  % dynamic viscosity of seawater (kg m^-1 s^-1)
    r_tot = particle.r_tot;  % radius of particle/algae system (m)
    r_A = kooi_constants.r_A;  % radius of individual algae (m)
    V_s = get_settling_velocity(particle, S, T);  % settling velocity of particle (m/s)
    gamma = kooi_constants.gamma; % shear rate (s^-1)
    
    D_pl = k * (T + 273.16) ./ (6*pi * mu_sw * r_tot);   % diffusivity of plastic particle (m^2 s^-1)
    D_A = k * (T + 273.16) ./ (6*pi * mu_sw * r_A);      % diffusivity of algae cell (m^2 s^-1)
    Beta_A_brownian = 4*pi * (D_pl + D_A) * (r_tot + r_A);  % brownian motion kernel rate (m^3 s^-1)
   
    Beta_A_settling = 1/2 * pi * r_tot^2 * V_s;  % differential settling kernel rate (m^3 s^-1)
    
    Beta_A_shear = 1.3 * gamma * (r_tot + r_A)^3;  % advective shear kernel rate (m^3 s^-1)
    
    Beta_A = Beta_A_brownian + Beta_A_settling + Beta_A_shear;  % encounter kernel rate (m^3 s^-1)
end

