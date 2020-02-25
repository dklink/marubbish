function growth_rate = optimal_temp_algae_growth(I)
%OPTIMAL_TEMP_ALGAE_GROWTH Calculate algae growth rate, light dependent,
%   assuming optimal temperature for growth.  Kooi 2017 eq. 17, from
%   Bernard 2012, eq. 3.
%   I: light intensity at the particle's location (micro mol quanta m^-2 s^-1)
%   return: growth rate under optimal temp (s^-1)
    mu_max = kooi_constants.mu_max; % maximum growth rate (s^-1)
    alpha = kooi_constants.alpha;   % initial slope (s^-1)
    I_opt = kooi_constants.I_opt;   % optimal light intensity (micro mol quanta m^-2 s^-1)
    % I and I_opt must use Bernard's light units for the (sadly unit dependent) parameterization: micro mol quanta m^-2 s^-1
    
    growth_rate = mu_max * I ./ (I + mu_max/alpha * (I./I_opt - 1).^2);
    % growth rate, optimal temp (s^-1)
end
