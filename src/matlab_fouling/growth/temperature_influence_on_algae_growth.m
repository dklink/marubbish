function Phi = temperature_influence_on_algae_growth(T)
%TEMPERATURE_INFLUENCE_ON_ALGAE_GROWTH Eq. 18, Kooi
%   T: temperature at the particle's location (Celsius)
%   return: scaling effect of temperature on optimal-temp growth rate (unitless)
    T_min = kooi_constants.T_min;   % min temp for growth (Celsius)
    T_max = kooi_constants.T_max;   % max temp for growth (Celsius)
    T_opt = kooi_constants.T_opt;   % optimal temp for growth (Celsius)
    
    numerator = (T - T_max) .* (T - T_min).^2;
    denominator = (T_opt - T_min) * ...
        ((T_opt - T_min)*(T - T_opt) - (T_opt - T_max)*(T_opt + T_min - 2*T));
    Phi = numerator ./ denominator;
end
