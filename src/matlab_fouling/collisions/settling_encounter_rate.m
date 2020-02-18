function Beta_settling = settling_encounter_rate(particle, V_s)
%SETTLING_ENCOUNTER_RATE kooi eq. 14
%   particle: the particle
%   V_s: settling velocity of particle (m/s)
%   
    r_tot = particle.r_tot;
    Beta_settling = 1/2 * pi * r_tot.^2 .* abs(V_s);  % differential settling kernel rate (m^3 s^-1)
end

