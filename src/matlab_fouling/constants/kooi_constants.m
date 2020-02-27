classdef kooi_constants
    % kooi_constants  Constants defined in Kooi 2017
    properties (Constant)
        % ALGAE PROPERTIES
        
        V_A = 2e-16; % volume of individual algae particle (m^3)
        r_A = nthroot(3 / (4*pi) * kooi_constants.V_A, 3);
        gamma = 1.7e5 / constants.seconds_per_day; % shear rate (s^-1)
        carbon_per_algae = 2726 * 1e-9; % mass carbon per algal cell (mg carbon (algal cell)^-1)
        m_A = .39 / constants.seconds_per_day;  % mortality rate (s^-1)
        T_min = .2;   % min temp for growth (Celsius)
        T_max = 33.3;   % max temp for growth (Celsius)
        T_opt = 26.7;   % optimal temp for growth (Celsius)
        Q_10 = 2; % Temperature dependence coefficient respiration (unitless)
        Resp_A = .1 / constants.seconds_per_day; % Respiration rate (s^-1)
        rho_A = 1388; % density of algae (kg m^-3)
        mu_max = 1.85 / constants.seconds_per_day; %  max growth rate algae (s^-1)
        alpha = .12 / constants.seconds_per_day;  % initial slope growth rate algae (s^-1)
        I_opt = 1.75392e13 / constants.seconds_per_day; % optimal light intensity algae growth (micro mol quanta m^-2 s^-1)
        
        %PLASTIC PROPERTIES
        rho_LDPE = 920;  % density of low-density polyethylene (kg m^-3)
        rho_HDPE = 940;  % density of high-density polyethylene (kg m^-3)
        rho_PP = 840;   % density of polypropylene (kg m^-3)
        rho_PS = 1050; % density of Polystyrene (kg m^-3)
        rho_PVC = 1380; % density of Polyvinylchloride
    end
end
