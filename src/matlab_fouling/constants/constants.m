classdef constants
    % universal physical constants and general definitions
    properties (Constant)
        k = 1.0306e-13 / constants.seconds_per_day^2;  % boltzmann constant (m^2 kg s^-2 K^-1)
        seconds_per_day = 86400;  % (s day^-1)
        seconds_per_hour = 3600;
        liters_per_cubic_meter = 1000;
        g = 9.81; % standard gravity (m s^-2)
        
        subtropical_lat_max = 35; % degrees N/S, max extent of tropical/subtropical zone
                                    %http://glossary.ametsoc.org/wiki/Subtropics                        
        arctic_circle_lat = 66.5; % degreees N/S, http://glossary.ametsoc.org/wiki/Arctic_circle
        
        NP_lat = 25.428321;   % lat of random spot near hawaii
        NP_lon = -151.773256; % lon of random spot near hawaii
    end
end