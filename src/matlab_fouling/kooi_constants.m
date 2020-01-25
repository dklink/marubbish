classdef kooi_constants
    % kooi_constants  Constants defined in Kooi 2017
    properties (Constant)
        V_A = 2e-16; % volume of individual algae particle (m^-3)
        r_A = nthroot(3 / (4*pi) * kooi_constants.V_A, 3);  % radius of individual algal particle (m)
        gamma = 1.7e5 / constants.seconds_per_day; % shear rate (s^-1, converted from Kooi's value in d^-1)
        carbon_per_algae = 2726 * 10e-9; % mass carbon per algal cell (mg carbon (algal cell)^-1)
    end
    methods (Static)
        function chl_to_C = chl_to_carbon_ratio (T, I)
        % chl_to_carbon_ratio  parameterization from Cloern 1995, Kooi's source
        % T: water temperature (Celsius)
        % I: light intensity (mol quanta m^-2 day^-2)
        % return: mass chlorophyll-a to mass Carbon ratio (mg chl (mg C)^-1)
            chl_to_C = 0.003 + 0.0154 * exp(0.050*T) .* exp(-0.059 * I);
        end
    end
end
