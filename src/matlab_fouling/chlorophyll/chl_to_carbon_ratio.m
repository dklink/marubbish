function chl_to_C = chl_to_carbon_ratio (T, I)
% chl_to_carbon_ratio  parameterization from Cloern 1995, Kooi's source
% T: water temperature (Celsius)
% I: light intensity (mol quanta m^-2 s^-1)
% return: mass chlorophyll-a to mass Carbon ratio (kg chl (kg C)^-1)
    % Cloern uses units (mol quanta m^-2 day^-1), hence conversion
    mu_prime = 1; %from N / (K_N + N), Cloern eq. 14, when 
                    % N (limiting nutrient concentration) is very
                    % large (i.e. no nutrient limitation, which Kooi assumes)
                    
    I_cloern_units = I * constants.seconds_per_day;  % mol quanta m^-2 day^-1, as Cloern uses
    chl_to_C = 0.003 + 1.0154 * exp(0.050*T) .* exp(-0.059 * I_cloern_units) * mu_prime;
                      %0.0154 is correct, kooi's paper says 1.0154.
                      %impacts settling time
end