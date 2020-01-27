classdef Particle
    % Particle  represents a spherical plastic particle with spherical algal shell
    properties
        r_pl    % radius of plastic core (m)
        rho_pl  % density of plastic core (kg m^-3)
        rho_bf  % density of algae cells
        A       % # attached algae cells
        lat     % latitude (degrees north)
        lon     % longitude (degrees east)
        z       % depth, positive down (m)
    end
    methods
        function obj = Particle (r_pl, rho_pl, A, lat, lon, z)
        % Particle: constructor
            obj.r_pl = r_pl;
            obj.rho_pl = rho_pl;
            obj.A = A;
            obj.lat = lat;
            obj.lon = lon;
            obj.z = z;
            obj.rho_bf = kooi_constants.rho_A;
        end
        function density = rho_tot (obj)
        %rho_tot: the density of the particle/algae conglomerate (kg m^-3)
            density = (obj.rho_pl*obj.V_pl + obj.rho_bf*obj.V_bf) ...
                            / obj.V_tot;
        end
        function biofilm_thickness = t_bf (obj)
        % t_bf: the thickness of the algal layer (m)
            biofilm_thickness = obj.r_tot - obj.r_pl;
        end
        function diameter = D_n (obj)
        % D_n: equivalent spherical diameter (m)
            % particles are assumed spheres, so this is simple
            diameter = 2*obj.r_tot();
        end
        function radius = r_tot (obj)
        % r_tot: the radius of the plastic/algae conglomerate (m)
            radius = nthroot(3/(4*pi) * obj.V_tot(), 3);
        end
        function volume = V_tot (obj)
        % V_tot: the volume of the plastic/algae conglomerate (m^3)
            volume = obj.V_bf() + obj.V_pl();
        end
        function volume = V_pl (obj)
        % V_pl: the volume of the plastic particle (m^3)
            volume = 4/3 * pi  * obj.r_pl^3;
        end
        function volume = V_bf (obj)
        % V_bf: the volume of the algal layer (m^3)
            volume = kooi_constants.V_A * obj.A;
        end
        function surface_area = theta_pl (obj)
        % theta_pl: the surface area of the plastic particle (m^2)
            surface_area = 4 * pi * obj.r_pl^2;
        end
    end
end