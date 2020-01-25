classdef particle
    % particle  represents a spherical plastic particle with spherical algal shell
    properties (Access = public)
        r_pl    % radius of plastic particle (m)
        A       % # attached algae cells
        lat     % latitude (degrees north)
        lon     % longitude (degrees east)
        z       % depth, positive down (m)
    end
    methods (Access = public)
        function radius = r_tot (obj)
        % r_tot: the radius of the plastic/algae conglomerate (m)
            radius = obj.r_pl + obj.t_bf;
        end
        function biofilm_thickness = t_bf (obj)
        % t_bf: the thickness of the algal layer (m)
            biofilm_thickness = nthroot(obj.V_tot * 3/(4*pi), 3) - obj.r_pl;
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
            volume = kooi_constants.V_A * obj.A * obj.theta_pl;
        end
        function surface_area = theta_pl (obj)
        % theta_pl: the surface area of the plastic particle (m^2)
            surface_area = 4 * pi * obj.r_pl^2;
        end
    end
end