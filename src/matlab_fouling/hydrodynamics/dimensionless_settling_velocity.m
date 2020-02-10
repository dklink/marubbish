function omega_star = dimensionless_settling_velocity (particle, S, T)
    % dimensionless_settling_velocity: kooi 2017 eq. 3
    % particle: particle for which to calculate
    % S: salinity at particle (g kg^-1)
    % T: temperature at particle (Celsius)
    % return: dimensionless settling velocity (unitless)
    D_star = dimensionless_particle_diameter(particle, S, T);    
    
    if D_star < .05
        omega_star = 1.74e-4 * D_star^2;
    elseif D_star <= 5e9
        log_w_s = -3.76715 + 1.92944*log10(D_star) - ...
          0.09815 * log10(D_star)^2 - 0.00575 * log10(D_star)^3 + ...
            0.00056*log10(D_star)^4;
        omega_star = 10^(log_w_s);
    else
        error("Omega_star undefined; particle too big");
    end
    
end
