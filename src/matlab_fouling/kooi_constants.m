classdef kooi_constants
    % kooi_constants  Constants defined in Kooi 2017
    properties (Constant)
        % ALGAE PROPERTIES
        V_A = 2e-16; % volume of individual algae particle (m^-3)
        r_A = nthroot(3 / (4*pi) * kooi_constants.V_A, 3);  % radius of individual algal particle (m)
        gamma = 1.7e5 / constants.seconds_per_day; % shear rate (s^-1)
        carbon_per_algae = 2726 * 10e-9; % mass carbon per algal cell (mg carbon (algal cell)^-1)
        mu_max = 1.85 / constants.seconds_per_day;  % maximum growth rate (s^-1)
        alpha = .12 / constants.seconds_per_day;    % initial growth slope (s^-1)
        I_opt = 1.75392e13 * 1e-6 / constants.seconds_per_day  % optimal light intensity for growth (mol quanta m^-2 s^-1)
        T_min = .2;   % min temp for growth (Celsius)
        T_max = 33.3;   % max temp for growth (Celsius)
        T_opt = 26.7;   % optimal temp for growth (Celsius)
    end
    methods (Static)
        function chl_to_C = chl_to_carbon_ratio (T, I)
        % chl_to_carbon_ratio  parameterization from Cloern 1995, Kooi's source
        % T: water temperature (Celsius)
        % I: light intensity (mol quanta m^-2 s^-1)
        % return: mass chlorophyll-a to mass Carbon ratio (mg chl (mg C)^-1)
            I_converted = I * constants.seconds_per_day;
            % Cloern uses units (mol quanta m^-2 day^-1), hence conversion
            chl_to_C = 0.003 + 0.0154 * exp(0.050*T) .* exp(-0.059 * I_converted);
        end
    end
end
