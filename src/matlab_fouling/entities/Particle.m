classdef Particle < handle
    % Particle  represents a spherical plastic particle with spherical algal shell
    properties (Constant)
        rho_bf = kooi_constants.rho_A;
    end
    properties
        % constants
        r_pl    % radius of plastic core (m)
        rho_pl  % density of plastic core (kg m^-3)
        V_pl  % volume of plastic core
        theta_pl  % surface area of plastic core
        
        % changing properties
        A       % concentration attached algae cells on surface (# cells m^-2)
        lat     % latitude (degrees north)
        lon     % longitude (degrees east)
        z       % depth, positive down (m)
        V_s     % current settling velocity, positive down (m / s)
        
        % derivative properties
        r_tot % needed
        rho_tot % needed
    end
    methods
        function obj = Particle (r_pl, rho_pl, A, lat, lon, z)
            % Particle: constructor
            % Object Initialization %
            % Call superclass constructor before accessing object
            % You cannot conditionalize this statement
            obj = obj@handle();
            % intitialize constants
            obj.r_pl = r_pl;
            obj.V_pl = 4/3 * pi * r_pl.^3;
            obj.theta_pl = 4 * pi * r_pl.^2;
            obj.rho_pl = rho_pl;

            % initialize changing properties
            obj.A = A;
            obj.lat = lat;
            obj.lon = lon;
            obj.z = z;
            obj.V_s = 0;
            
            %initialize derivative properties to zero (p ugly but it works)
            obj.r_tot = 0;
            obj.rho_tot = 0;
            % fill in derivate properties of A
            obj.calculate_derivative_properties();
        end
        function update_particle_for_growth(obj, dA)
            % lets particle state only be recomputed once per timestep
            % update A, then update everything which depends on A
            obj.A = obj.A + dA;
            obj.calculate_derivative_properties();
        end
        function calculate_derivative_properties(obj)
            % update all the fields of particle that depend on A
            new_V_bf = kooi_constants.V_A * obj.A * obj.theta_pl;
            new_V_tot = new_V_bf + obj.V_pl;
            new_r_tot = (3/(4*pi) * new_V_tot)^(1/3);
            new_rho_tot = (obj.rho_pl.*obj.V_pl + obj.rho_bf.*new_V_bf) ...
                            ./ new_V_tot;
                        
            obj.r_tot = new_r_tot;
            obj.rho_tot = new_rho_tot;
        end
        function update_particle_from_rho_tot(obj, rho_tot)
            % update all the relevant particle params given its total
            % density
            V_bf = obj.V_pl * (rho_tot - obj.rho_pl) / (obj.rho_bf - rho_tot);
            obj.A = V_bf / (kooi_constants.V_A * obj.theta_pl);
            obj.calculate_derivative_properties();
            assert_equal(obj.rho_tot, rho_tot);  % make sure it worked out
        end
    end
end
