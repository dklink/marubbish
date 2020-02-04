%fig1a();
%fig1b();
%fig1c();
fig1d();  % damping strongly affected by background concentration of algae, somehow
%figS2();

function fig1a()
    %kooi fig 1a
    num_days = 110;
    dt_hours = .1;  % behavior stabilizes below .2 or so (.7 mimics kooi exactly)
    particle_radius = 1e-3; % m
    [t, z, ~] = get_t_vs_z(num_days, dt_hours, particle_radius);

    z = z(t/seconds_per_day > 100);
    t = t(t/seconds_per_day > 100);
    plot_t_vs_z(t, z, '1 mm');
end

function fig1b()
    %kooi fig 1b
    num_days = 150;
    dt_hours = 1;  % behavior stabilizes below 1 or so
    particle_radius = 1e-4; % m
    [t, z, ~] = get_t_vs_z(num_days, dt_hours, particle_radius);

    z = z(t/seconds_per_day > 100);
    t = t(t/seconds_per_day > 100);
    plot_t_vs_z(t, z, '0.1 mm');
end

function fig1c()
    %kooi fig 1c
    num_days = 1000;
    dt_hours = 1;  % behavior stabilizes below 2 or so
    particle_radius = 1e-5; % m
    [t, z, ~] = get_t_vs_z(num_days, dt_hours, particle_radius);

    z = z(t/seconds_per_day > 100);
    t = t(t/seconds_per_day > 100);
    plot_t_vs_z(t, z, '10 \mum');
end

function fig1d()
    %kooi fig 1b
    num_days = 10000;
    dt_hours = 4;  % behavior stabilizes below 5 or so
    particle_radius = 1e-6; % m
    [t, z, ~] = get_t_vs_z(num_days, dt_hours, particle_radius);

    z = z(t/seconds_per_day > 100);
    t = t(t/seconds_per_day > 100);
    plot_t_vs_z(t, z, '1 \mum');
end

function figS2()
    %kooi fig S2
    num_days = 120;
    dt_hours = .5;  % behavior stabilizes below 1 or so
    particle_radius = 1e-4; % m
    [t, z, rho] = get_t_vs_z(num_days, dt_hours, particle_radius);

    z = z(t/seconds_per_day > 100);
    rho = rho(t/seconds_per_day > 100);
    t = t(t/seconds_per_day > 100);
    plot_t_vs_z(t, z, '0.1 mm');
    plot_t_vs_rho(t, rho, '0.1 mm');
    ylim([920, 1060]);
    yline(mean(get_seawater_density(S_vs_z(z), T_vs_z(z), 0, 0, 0)));
end

function plot_t_vs_z(t, z, plot_title)
    figure;
    set(0, 'DefaultLineLineWidth', 2);
    plot(t/seconds_per_day, z);
    xlabel('days');
    ylabel('depth (m)');
    set(gca, 'YDir','reverse');
    title(plot_title);
    ylim([0, 80]);
end

function plot_t_vs_rho(t, rho, plot_title)
    figure;
    set(0, 'DefaultLineLineWidth', 2);
    plot(t/seconds_per_day, rho);
    xlabel('days');
    ylabel('densty (kg m^{-3})');
    title(plot_title);
end

function [t, z, rho] = get_t_vs_z(num_days, dt_hours, particle_radius)
    % gets z vs t for a LDPE particle in the North Pacific
        % (for replicating kooi fig 1)
        % particle_radius in meters
    % returns: [t, z] ([seconds, meters])

    NP_lat = 25.428321;   % lat and lon of spot near hawaii
    NP_lon = -151.773256; %

    p = Particle(particle_radius, kooi_constants.rho_LDPE, 0, NP_lat, NP_lon, 0);

    dt = seconds_per_hour*dt_hours;
    t = 1:dt:num_days*seconds_per_day;
    z = zeros(1, length(t));
    rho = zeros(1, length(t));

    chl_surf_np = kooi_constants.chl_surf_np;
    chl_ave_np = kooi_constants.chl_ave_np;
    z(1) = p.z;
    rho(1) = p.rho_tot;
    for i=2:length(t)
        I_surf = I_vs_time(t(i));
        T_z = T_vs_z(p.z);
        I_z = get_light_at_z(p.z, I_surf, chl_ave_np);
        S_z = S_vs_z(p.z);
        chl_z = get_chl_at_z(p.z, chl_surf_np);
        dAdt = get_algae_flux_for_particle(p, S_z, T_z, chl_z, I_z);

        p.A = p.A + dAdt * dt;

        % this approximates the position function
        V_s = get_settling_velocity(p, S_z, T_z);
        new_z = p.z + V_s * dt;
        if new_z < 0  % silly particle, you can't fly
            new_z = 0;
        end
        
        p.z = new_z;
        z(i) = new_z;
        rho(i) = p.rho_tot;
    end
end

function sph = seconds_per_hour()
    sph = 3600;
end

function spd = seconds_per_day()
    spd = seconds_per_hour*24;
end
