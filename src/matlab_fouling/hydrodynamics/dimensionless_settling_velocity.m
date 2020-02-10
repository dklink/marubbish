function omega_star = dimensionless_settling_velocity (particle, S, T)
    % dimensionless_settling_velocity: kooi 2017 eq. 3
    % particle: particle for which to calculate
    % S: salinity at particle (g kg^-1)
    % T: temperature at particle (Celsius)
    % return: dimensionless settling velocity (unitless)
    D_star = dimensionless_particle_diameter(particle, S, T);
    omega_star = 1.74e-4 * D_star^2;
    
    %{
    if D_star < .05
        omega_star = 1.74e-4 * D_star^2;
    elseif D_star <= 5e9
        log_w_s = -3.76715 + 1.92944*log(D_star) - ...
          0.09815 * log(D_star)^2 - 0.00575 * log(D_star)^3 + ...
            0.00056*log(D_star)^4;
        omega_star = exp(log_w_s);
    else
        error("Omega_star undefined; particle too big");
    end
    %}
end

% it appears Kooi doesn't follow the paper she references quite right;
% she only uses the small-particle approximation of omega_star
% perhaps due to an error in her conditioning on D_star magnitude.
