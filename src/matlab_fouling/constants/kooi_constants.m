classdef kooi_constants
    % kooi_constants  Constants defined in Kooi 2017
    properties (Constant)
        % ALGAE PROPERTIES
        
        V_A = 2e-16; % volume of individual algae particle (m^3)
        chl_surf_np = .05 * 1e-6;  % kg m^-3
        chl_ave_np = .151 * 1e-6;  % kg m^-3
        gamma = 1.7e5 / constants.seconds_per_day; % shear rate (s^-1)
        carbon_per_algae = 2726 * 1e-9 * 1e-6; % mass carbon per algal cell (kg carbon (algal cell)^-1)
        m_A = .39 / constants.seconds_per_day;  % mortality rate (s^-1)
        T_min = .2;   % min temp for growth (Celsius)
        T_max = 33.3;   % max temp for growth (Celsius)
        T_opt = 26.7;   % optimal temp for growth (Celsius)
        Q_10 = 2; % Temperature dependence coefficient respiration (unitless)
        Resp_A = .1 / constants.seconds_per_day; % Respiration rate (s^-1)
        rho_A = 1388; % density of algae (kg m^-3)
        mu_max = 1.85 / constants.seconds_per_day; %  max growth rate algae (s^-1)
        alpha = .12 / constants.seconds_per_day;  % initial slope growth rate algae (s^-1)
        I_opt = 1.75392e13 * 1e-6 / constants.seconds_per_day; % optimal light intensity algae growth (mol quanta m^-2 s^-1)
        
        %PLASTIC PROPERTIES
        rho_LDPE = 920;  % density of low-density polyethylene (kg m^-3)
        rho_HDPE = 940;  % density of high-density polyethylene (kg m^-3)
        rho_PP = 840;   % density of polypropylene (kg m^-3)
        rho_PS = 1050; % density of Polystyrene (kg m^-3)
        rho_PVC = 1380; % density of Polyvinylchloride
        
        %VERTICAL PROFILES
        %Temperature
        T_surf_NP = 25;  % Temp at ocean surface North Pacific (C)
        T_bot_NP = 1.5;  % Temp at ocean bottom North Pacific (C)
        p_NP = 2;  % Steepness temp decrease (unitless)
        z_c_NP = 300;  % Depth thermocline North Pacific (m)
        %Salinity
        z_fix_NP = -1000;  % depth below which salinity is fixed (m)
        S_fix_NP = 34.6;    % fixed salinity after z_fix_NP (g / kg)
        b_1_NP = 9.9979979767e-17;
        b_2_NP = 1.0536246487e-12;
        b_3_NP = 3.9968286066e-9;
        b_4_NP = 6.5411526250e-6;
        b_5_NP = 4.1954014008e-3;
        b_6_NP = 3.5172984035e1;
        %Light
        I_m = 1.2e8 * 1e-6 / constants.seconds_per_day; % Surface light intensity at noon (mol quanta m^-2 s^-1)
        eps_w = .2; % extinction coefficient water (m^-1)
        eps_p = .02 * 1e6 / constants.liters_per_cubic_meter; % orig units: m^-1 (mg chl)^-1 L
                                        % units after my conversion: m^2 (kg chl)^-1
        % I don't trust the eps constants at all.  Need to do own work. 
    end
    methods (Static)
        function radius = r_A ()
            radius = nthroot(3 / (4*pi) * kooi_constants.V_A, 3);  % radius of individual algal particle (m)
        end
    end
end
