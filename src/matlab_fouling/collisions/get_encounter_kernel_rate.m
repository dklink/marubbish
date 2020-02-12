function Beta_A = get_encounter_kernel_rate(particle, S, T)
%GET_ENCOUNTER_KERNEL_RATE  Kooi 2017 eq. 14-15
%   Detailed explanation goes here
% particle: the particle we're calculating for
% S: salinity at the particle (g kg^-1)
% T: temperature at the particle (Celsius)
    V_s = get_settling_velocity(particle, S, T);  % settling velocity of particle (m/s)
    
    Beta_A_brownian = brownian_encounter_rate(particle, S, T);
    Beta_A_settling = settling_encounter_rate(particle, V_s);
    Beta_A_shear = shear_encounter_rate(particle);
    Beta_A = Beta_A_brownian + Beta_A_settling + Beta_A_shear;  % encounter kernel rate (m^3 s^-1)
end

