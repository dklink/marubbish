function growth_rate = get_algae_growth(particle, T, I)
%GET_ALGAE_GROWTH calculate instantaneous growth rate.  Kooi 2017, eq. 11, term 2
%   particle: the particle for which to calculate growth
%   T: temperature at the particle's location (Celsius)
%   I: light intensity at the particle's location (mol quanta m^-2 s^-1)
%   return: instantaneous algae growth rate (# algae cells s^-1)
    T_min = kooi_constants.T_min;   % minimum temp for growth (Celsius)
    T_max = kooi_constants.T_max;   % maximum temp for growth (Celsius)
    
    if (T > T_min) && (T < T_max)
        mu_a = optimal_temp_algae_growth(I) .* temperature_influence_on_algae_growth(T);
        growth_rate = mu_a * particle.A;    % (# algae cells s^-1)
    else
        growth_rate = 0;
    end
end
