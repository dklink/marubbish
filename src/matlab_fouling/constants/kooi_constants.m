classdef kooi_constants
    % kooi_constants  Constants defined in Kooi 2017
    properties (Constant)
        % ALGAE PROPERTIES
        
        V_A = 2e-16; % volume of individual algae particle (m^-3)
        gamma = 1.7e5 / constants.seconds_per_day; % shear rate (s^-1)
        carbon_per_algae = 2726 * 1e-9; % mass carbon per algal cell (mg carbon (algal cell)^-1)
        T_min = .2;   % min temp for growth (Celsius)
        T_max = 33.3;   % max temp for growth (Celsius)
        T_opt = 26.7;   % optimal temp for growth (Celsius)
        Q_10 = 2; % Temperature dependence coefficient respiration (unitless)
        R_A = .1 / constants.seconds_per_day; % Respiration rate (s^-1)
        rho_A = 1388; % kg m^-3
        I_m = 1.2e8 * 1e-6 / constants.seconds_per_day; % Surface light intensity at noon (mol quanta m^-2 s^-1)
    end
    methods (Static)
        function radius = r_A ()
            radius = nthroot(3 / (4*pi) * kooi_constants.V_A, 3);  % radius of individual algal particle (m)
        end
    end
end
