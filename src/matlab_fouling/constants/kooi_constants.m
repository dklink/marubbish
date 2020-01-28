classdef kooi_constants
    % kooi_constants  Constants defined in Kooi 2017
    properties (Constant)
        % ALGAE PROPERTIES
        
        V_A = 2e-16; % volume of individual algae particle (m^-3)
        r_A = nthroot(3 / (4*pi) * kooi_constants.V_A, 3);  % radius of individual algal particle (m)
        gamma = 1.7e5 / constants.seconds_per_day; % shear rate (s^-1)
        carbon_per_algae = 2726 * 10e-9; % mass carbon per algal cell (mg carbon (algal cell)^-1)
        alpha = .12 / constants.seconds_per_day;    % initial growth slope (s^-1)
        T_min = .2;   % min temp for growth (Celsius)
        T_max = 33.3;   % max temp for growth (Celsius)
        T_opt = 26.7;   % optimal temp for growth (Celsius)
        Q_10 = 2; % Temperature dependence coefficient respiration (unitless)
        R_A = .1 / constants.seconds_per_day; % Respiration rate (s^-1)
        rho_A = 1388; % kg m^-3
        I_m = 1.2e8 * 1e-6 / constants.seconds_per_day; % Surface light intensity at noon (mol quanta m^-2 s^-1)
    end
    methods (Static)
        function chl_to_C = chl_to_carbon_ratio (T, I)
        % chl_to_carbon_ratio  parameterization from Cloern 1995, Kooi's source
        % T: water temperature (Celsius)
        % I: light intensity (mol quanta m^-2 s^-1)
        % return: mass chlorophyll-a to mass Carbon ratio (mg chl (mg C)^-1)
            % Cloern uses units (mol quanta m^-2 day^-1), hence conversion
            chl_to_C = 0.003 + 0.0154 * exp(0.050*T) .* exp(-0.059 * I);
        end
        function w_s = omega_star (particle, S, T)
            % omega_star: dimensionless settling velocity, kooi eq. 3
            % particle: particle for which to calculate
            % S: salinity at particle (g kg^-1)
            % T: temperature at particle (Celsius)
            % return: dimensionless settling velocity (unitless)
            D_star = kooi_constants.dimensionless_particle_diameter(particle, S, T);
            if D_star < .05
                w_s = 1.74 * 10e-4 * D_star^2;
            elseif D_star <= 5 * 10e9
                w_s = -3.76715 + 1.92944*log(D_star) - ...
                  0.09815 * log(D_star)^2 - 0.00575 * log(D_star)^3 + ...
                    0.00056*log(D_star)^4;
            else
                error("Omega_star undefined for this particle");
            end
        end
        function D_star = dimensionless_particle_diameter (particle, S, T)
            % DIMENSIONLESS_PARTICLE_DIAMETER: eq. 4
            % particle: particle for which to calculate
            % S: salinity at particle (g kg^-1)
            % T: temperature at particle (Celsius)
            % return: dimensionless particle diameter (m)
            rho_tot = particle.rho_tot; % kg m^-3
            rho_sw = get_seawater_density(S, T, particle.lat, particle.lon, particle.z); % kg m^-3
            g = constants.g; % m s^-2
            D_n = particle.D_n;  % equivalent spherical particle diameter
            nu_sw = kinematic_viscosity_seawater(S, T, rho_sw); % m^2 s^-1
            
            D_star = (rho_tot - rho_sw) * g * D_n^3 / (rho_sw * nu_sw^2);
        end
    end
end
