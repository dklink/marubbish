classdef kooi_constants
    % kooi_constants  Constants defined in Kooi 2017
    properties (Constant)
        % ALGAE PROPERTIES
        
        V_A = 2e-16; % volume of individual algae particle (m^3)
        chl_surf_np = .05;
        chl_ave_np = .151;
        gamma = 1.7e5 / constants.seconds_per_day; % shear rate (s^-1)
        carbon_per_algae = 2726 * 1e-9; % mass carbon per algal cell (mg carbon (algal cell)^-1)
        m_A = .39 / constants.seconds_per_day;  % mortality rate (s^-1)
        T_min = .2;   % min temp for growth (Celsius)
        T_max = 33.3;   % max temp for growth (Celsius)
        T_opt = 26.7;   % optimal temp for growth (Celsius)
        Q_10 = 2; % Temperature dependence coefficient respiration (unitless)
        R_A = .1 / constants.seconds_per_day; % Respiration rate (s^-1)
        rho_A = 1388; % kg m^-3
        I_m = 1.2e8 * 1e-6 / constants.seconds_per_day; % Surface light intensity at noon (mol quanta m^-2 s^-1)
        eps_w = .2; % extinction coefficient water (m^-1)
        eps_p = .02 / constants.liters_per_cubic_meter; % orig units: m^-1 (mg chl)^-1 L
                                        % units after my conversion: m^2 (mg chl)^-1
        % I don't trust the eps constants at all.  Need to do own work.
        
        %PLASTIC PROPERTIES
        rho_LDPE = 920;  % density of low-density polyethylene (kg m^-3)
        rho_HDPE = 940;  % density of high-density polyethylene (kg m^-3)
        rho_PP = 840;   % density of polypropylene (kg m^-3)
    end
    methods (Static)
        function radius = r_A ()
            radius = nthroot(3 / (4*pi) * kooi_constants.V_A, 3);  % radius of individual algal particle (m)
        end
    end
end
