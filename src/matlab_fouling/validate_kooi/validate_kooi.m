%fig1a();
%fig1b();
%fig1c();
%fig1d();  % damping strongly affected by collision rate!
%fig2();
%figS2();
%z_vs_growth();

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
    num_days = 2000;
    dt_hours = 12;  % behavior stabilizes below 5 or so
    particle_radius = 1e-6; % m
    [t, z, meta] = get_t_vs_z(num_days, dt_hours, particle_radius);
    rho = meta{1};
    coll = meta{2};
    growth = meta{3};
    mort = meta{4};
    resp = meta{5};
    
    %z = z(t/seconds_per_day > 100);
    %rho = rho(t/seconds_per_day > 100);
    %t = t(t/seconds_per_day > 100);
    plot_t_vs_z(t, z, '1 \mum');
    xlim([1000, 2000]);
    plot_t_vs_rho(t, rho, '1 \mum');
    xlim([1000, 2000])
    figure; hold on;
    t = t/seconds_per_day;
    plot(t, coll, 'DisplayName', 'collisions');
    plot(t, growth, 'DisplayName', 'growth');
    plot(t, -mort, 'DisplayName', 'mortality');
    plot(t, -resp, 'DisplayName', 'respiration');
    plot(t, coll+growth-mort-resp, 'DisplayName', 'flux');
    legend();
    xlim([1000, 2000]);
end

function z_vs_growth()
    p = Particle(NaN, NaN, 1, NaN, NaN, NaN);
    z = linspace(0, 50);
    hour = 0;
    figure;
    while true
        clf('reset');
        hold on;

        I_surf = I_vs_time(hour*seconds_per_hour);
        I = get_light_at_z(z, I_surf, kooi_constants.chl_ave_np);
        T = T_vs_z(z);
        growth = zeros(1, 100);
        for i=1:100
            growth(i) = get_algae_growth(p, T(i), I(i));
        end
        resp = get_algae_respiration(p, T);
        mort = get_algae_mortality(p);
        plot(growth, z, 'DisplayName', 'growth');
        set(gca, 'YDir', 'reverse');
        xlabel('Algal flux (# cells s^{-1})')
        ylabel('depth (m)')
        plot(-(resp+mort), z, 'DisplayName', 'death');
        plot(growth - (resp+mort), z, 'DisplayName', 'flux');
        xline(0, 'LineStyle', '--', 'DisplayName', 'zero');
        legend();
        title(sprintf('hour %d', hour));
        pause(.5);
        hour = mod(hour + 1, 24);
    end
    
    
end

function fig2()
    radii = [1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2];
    surface_area = 4*pi*radii.^2;

    %radii = sqrt(surface_area/(4*pi))
    settling_time = zeros(1, length(radii));
    for i=1:length(radii)
        [t, z, ~] = get_t_vs_z(30, .05, radii(i)); % note: smaller timestep lowers settling time until .05 or so
        settling_time(i) = t(find(z > 0, 1));
    end
    figure; hold on;
    kooi_data = [1.276e-13	0.254  % from GraphClick of fig 2
                1.287e-11	12.265
                1.220e-9	22.196
                1.284e-7	24.319
                1.258e-5	24.519
                .001        25.377];

    plot(kooi_data(:,1), kooi_data(:,2), '^-.', 'DisplayName', 'kooi')
    plot(surface_area, settling_time/seconds_per_day, '^-.', 'DisplayName', 'klink');
    ylabel('Settling onset (days)');
    xlabel('Surface (m^2)');
    ylim([0, 40]);
    set(gca,'Xscale','log');
    title('Kooi Fig 2, LDPE');
    legend();
end

function figS2()
    %kooi fig S2
    num_days = 120;
    dt_hours = .5;  % behavior stabilizes below 1 or so
    particle_radius = 1e-4; % m
    [t, z, meta] = get_t_vs_z(num_days, dt_hours, particle_radius);
    rho = meta{1};
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

function [t, z, meta] = get_t_vs_z(num_days, dt_hours, particle_radius)
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
    coll = zeros(1, length(t));
    growth = zeros(1, length(t));
    mort = zeros(1, length(t));
    resp = zeros(1, length(t));

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
        
        coll(i) = get_algae_collisions(p, S_z, T_z, chl_z, I_z);
        growth(i) = get_algae_growth(p, T_z, I_z);
        mort(i) = get_algae_mortality(p);
        resp(i) = get_algae_respiration(p, T_z);
        dAdt = coll(i) + growth(i) - mort(i) - resp(i);
        p.A = p.A + 1.1*dAdt * dt;

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
    meta = {rho coll growth mort resp};
end

function sph = seconds_per_hour()
    sph = 3600;
end

function spd = seconds_per_day()
    spd = seconds_per_hour*24;
end
