classdef constants
    % universal physical constants and general definitions
    properties (Constant)
        k = 1.380649e-23;  % boltzmann constant (m^2 kg s^-2 K^-1)
        seconds_per_day = 86400;  % (s day^-1)
        liters_per_cubic_meter = 1000;
        g = 9.81; % standard gravity (m s^-2)
        
        subtropical_lat_max = 35; % degrees N/S, max extent of tropical/subtropical zone
                                    %http://glossary.ametsoc.org/wiki/Subtropics                        
        arctic_circle_lat = 66.5; % degreees N/S, http://glossary.ametsoc.org/wiki/Arctic_circle
    end
end