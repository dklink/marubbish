classdef BernardConstants
    % Constants from Bernard 2012
    properties (Constant)
        K_m = 15.0 * 1e-6; % Michaelis Constant for N. Oceanica (mol quanta m^-2 s^-1)
                            % from section 3.3
        mu_max = 1.85 / constants.seconds_per_day; % for N. Oceanica (s^-1)
                                                    % from table 4
    end
end