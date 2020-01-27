function growth_rate = optimal_temp_algae_growth(I)
%OPTIMAL_TEMP_ALGAE_GROWTH Calculate algae growth rate, light dependent,
%       assuming optimal temperature for growth.
%       Kooi 2017 eq. 17 cites Bernard 2012, eq. 3, and uses his fitted parameters
%       for N. Oceanica.  Bernard offers a simpler model for N. Oceanica in
%       section 3.3.  We use that here, as eq. 3 is unit-dependent and thus
%       dangerous.
%   I: light intensity at the particle's location (mol quanta m^-2 s^-1)
%   return: growth rate under optimal temp (s^-1)
    mu_max = BernardConstants.mu_max; % maximum growth rate (s^-1)
    K_m = BernardConstants.K_m; % Michaelis Constant (mol m^-2 s^-1)
    
    growth_rate = mu_max * I ./ (I + K_m); % growth rate, optimal temp (s^-1)
end
