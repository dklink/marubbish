%[t, z, meta] = fig1a();
%[t, z, meta] = fig1b();
%[t, z, meta] = fig1c();
%[t, z, meta] = fig1d();  % damping strongly affected by collision rate!
%fig2(PlasticType.HDPE);
fig3(PlasticType.PP);
%plot_dominant_frequency();
%figS2();
%z_vs_growth();
%plot_period();


function [t, z, meta] = fig1a()
    %kooi fig 1a
    num_days = 110;
    dt_hours = .1;  % behavior stabilizes below .2 or so
    particle_radius = 1e-3; % m
    p = Particle(particle_radius, kooi_constants.rho_LDPE, 0, constants.NP_lat, constants.NP_lon, 0);
    [t, z, meta] = get_t_vs_z(num_days, dt_hours, p);

    z = z(t/constants.seconds_per_day > 100);
    t = t(t/constants.seconds_per_day > 100);
    plot_t_vs_z(t, z, '1 mm');  
    
    plot_freq_spectrum(t, z, dt_hours);
end

function [t, z, meta] = fig1b()
    %kooi fig 1b
    num_days = 150;
    dt_hours = 1;  % behavior stabilizes below 1 or so
    particle_radius = 1e-4; % m
    p = Particle(particle_radius, kooi_constants.rho_LDPE, 0, constants.NP_lat, constants.NP_lon, 0);
    [t, z, meta] = get_t_vs_z(num_days, dt_hours, p);

    z = z(t/constants.seconds_per_day > 100);
    t = t(t/constants.seconds_per_day > 100);
    plot_t_vs_z(t, z, '0.1 mm');
    
    plot_freq_spectrum(t, z, dt_hours);
end

function [t, z, meta] = fig1c()
    %kooi fig 1c
    num_days = 1000;
    dt_hours = 1;  % behavior stabilizes below 2 or so
    particle_radius = 1e-5; % m
    p = Particle(particle_radius, kooi_constants.rho_LDPE, 0, constants.NP_lat, constants.NP_lon, 0);
    [t, z, meta] = get_t_vs_z(num_days, dt_hours, p);

    z = z(t/constants.seconds_per_day > 100);
    t = t(t/constants.seconds_per_day > 100);
    plot_t_vs_z(t, z, '10 \mum');
    
    plot_freq_spectrum(t, z, dt_hours);
end

function [t, z, meta] = fig1d()
    %kooi fig 1b
    num_days = 10000;
    dt_hours = 1;  % behavior stabilizes below 1 or so
    particle_radius = 1e-6; % m
    p = Particle(particle_radius, kooi_constants.rho_LDPE, 0, constants.NP_lat, constants.NP_lon, 0);
    [t, z, meta] = get_t_vs_z(num_days, dt_hours, p);
    
    %z = z(t/constants.seconds_per_day > 100);
    %rho = rho(t/constants.seconds_per_day > 100);
    %t = t(t/constants.seconds_per_day > 100);
    plot_t_vs_z(t, z, '1 \mum');
    %{
    rho = meta{1};
    coll = meta{2};
    growth = meta{3};
    mort = meta{4};
    resp = meta{5};
    plot_t_vs_rho(t, rho, '1 \mum');
    xlim([1000, 2000])
    figure; hold on;
    t = t/constants.seconds_per_day;
    plot(t, coll, 'DisplayName', 'collisions');
    plot(t, growth, 'DisplayName', 'growth');
    plot(t, -mort, 'DisplayName', 'mortality');
    plot(t, -resp, 'DisplayName', 'respiration');
    plot(t, coll+growth-mort-resp, 'DisplayName', 'flux');
    legend();
    xlim([1000, 2000]);
    %}
    plot_freq_spectrum(t, z, dt_hours);
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

function fig2(plastic_type)    
    if plastic_type == PlasticType.LDPE
        density = kooi_constants.rho_LDPE;
        kooi_data = [1.276e-13	0.254  % from GraphClick of fig 2
                1.287e-11	12.265
                1.220e-9	22.196
                1.284e-7	24.319
                1.258e-5	24.519
                .001        25.377];
        linestyle = '-.^';
    elseif plastic_type == PlasticType.HDPE
        density = kooi_constants.rho_HDPE;
        kooi_data = [1.258e-13	0.248
                    1.257e-11	11.379
                    1.250e-9	21.493
                    1.237e-7	24.238
                    1.257e-5	24.350
                    0.001	24.471];
        linestyle = '-.d';
    elseif plastic_type == PlasticType.PP
        density = kooi_constants.rho_PP;
        kooi_data = [1.272e-13	0.291
                    1.247e-11	13.406
                    1.242e-9	23.459
                    1.215e-7	26.310
                    1.217e-5	26.360
                    0.001	26.448];
        linestyle = '-.s';
    else
        error("unrecognized plastic type");
    end

    surface_area = kooi_data(:, 1);
    radii = sqrt(surface_area / (4 * pi));
    settling_time = zeros(1, length(radii));
    for i=1:length(radii)
        p = Particle(radii(i), density, 0, constants.NP_lat, constants.NP_lon, 0);
        [t, z, ~] = get_t_vs_z(50, .05, p); % note: smaller timestep lowers settling time until .05 or so
        settling_time(i) = t(find(z > 0, 1));
    end
    
    hold on;
    
    plot(kooi_data(:,1), kooi_data(:,2), linestyle,'MarkerSize', 8, 'DisplayName', 'kooi')
    plot(surface_area, settling_time/constants.seconds_per_day, linestyle, 'MarkerSize', 8, 'DisplayName', 'klink');
    ylabel('Settling onset (days)');
    xlabel('Surface (m^2)');
    ylim([0, 40]);
    set(gca,'Xscale','log');
    title(sprintf('Kooi Fig 2, %s', plastic_type));
    legend();
end

function fig3(plastic_type)    
    if plastic_type == PlasticType.LDPE
        density = kooi_constants.rho_LDPE;
        kooi_data = [7.870e-6	4.353  % graphclick of fig 3
                    1.438e-5	8.975
                    1.117e-4	92.800
                    0.001	1007.943
                    0.011	3268.793];


        marker = '^';
    elseif plastic_type == PlasticType.HDPE
        density = kooi_constants.rho_HDPE;
        kooi_data = [7.586e-6	4.171
                    1.445e-5	8.863
                    1.104e-4	83.257
                    0.001	922.636
                    0.011	4159.560];
        marker = 'd';
    elseif plastic_type == PlasticType.PP
        density = kooi_constants.rho_PP;
        kooi_data = [7.861e-6	4.396
                    1.555e-5	10.204
                    1.187e-4	129.708
                    0.001	1096.100
                    0.012	7690.197];
        marker = 's';
    else
        error("unrecognized plastic type");
    end

    radii = [1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2];
    settling_velocity = zeros(1, length(radii));
    total_radius = zeros(1, length(radii));
    algae = zeros(1, length(radii));
    rho_max = zeros(1, length(radii));
    for i=1:length(radii)
        p = Particle(radii(i), density, 0, constants.NP_lat, constants.NP_lon, 0);
        [t, z, meta] = get_t_vs_z(50, .05, p); % note: smaller timestep lowers settling time until .05 or so
        r_tot = meta{6};
        v_s = meta{7};
        A = meta{8};
        rho = meta{1};
        [v_max, i_max] = max(v_s);
        settling_velocity(i) = v_max;
        total_radius(i) = r_tot(i_max);
        algae(i) = A(i_max);
        rho_max(i) = rho(i_max);
    end
    hold on;
    plot(kooi_data(:,1)*1e3, kooi_data(:,2), ...
        strcat('-.', marker),'MarkerSize', 8, 'DisplayName', 'kooi')
    plot(total_radius*1e3, settling_velocity*constants.seconds_per_day, ...
        strcat('-', marker), 'MarkerSize', 8, 'DisplayName', 'klink');
    set(gcf,'Position',[0, 83, 448, 687]); % match proportions of kooi's plot
    ylabel('Settling Velocity (m d^{-1})');
    xlabel('Total Radius (mm)');
    set(gca,'Xscale','log');
    set(gca, 'Yscale', 'log');
    ylim([1, 10000]);
    title(sprintf('Kooi Fig 3, %s', plastic_type));
    legend();
    
    % much closer to correct
    p = Particle(total_radius, rho_max, 0, 0, 0, 0);
    disp(rho_max);
    S = 25;  % this makes the chart match.   THIS! Why??
    T = 25;
    plot(total_radius*1e3, get_settling_velocity(p, S, T_vs_z(0))*constants.seconds_per_day, ...
        'DisplayName', 'S=25');
end

function plot_period()    
    % compares fig 1 periods, kooi and mine
    T_kooi = [4950/29, 450/23, 50/18, 10/10]; % period, days, from counting peaks in fig 1
    T_klink = zeros(1, length(T_kooi));
    functions = {@fig1d, @fig1c, @fig1b, @fig1a};
    radii = [1e-6, 1e-5, 1e-4, 1e-3];
    for i=1:4
        [t, z, ~] = functions{i}();
        dt_hours = (t(2)-t(1))/constants.seconds_per_hour;
        [f, P1] = get_freq_spectrum(t, z, dt_hours);
        T = 1./f;
        [~, max_i] = max(P1);
        T_klink(i) = T(max_i);
    end
    %close all;
    figure; hold on;
    plot(radii, T_kooi, 'MarkerSize', 8, 'DisplayName', 'kooi')
    plot(radii, T_klink, 'MarkerSize', 8, 'DisplayName', 'klink');
    ylabel('Period of main oscillation (days)');
    xlabel('Platic Radius (m)');
    set(gca,'Xscale','log');
    set(gca, 'Yscale', 'log');
    legend();
end

function figS2()
    %kooi fig S2
    num_days = 120;
    dt_hours = .5;  % behavior stabilizes below 1 or so
    particle_radius = 1e-4; % m
    p = Particle(particle_radius, kooi_constants.rho_LDPE, 0, NP_lat, NP_lon, 0);
    [t, z, meta] = get_t_vs_z(num_days, dt_hours, p);
    rho = meta{1};
    z = z(t/constants.seconds_per_day > 100);
    rho = rho(t/constants.seconds_per_day > 100);
    t = t(t/constants.seconds_per_day > 100);
    plot_t_vs_z(t, z, '0.1 mm');
    plot_t_vs_rho(t, rho, '0.1 mm');
    ylim([920, 1060]);
    yline(mean(get_seawater_density(S_vs_z(z), T_vs_z(z), 0, 0, 0)));
end

function plot_t_vs_z(t, z, plot_title)
    figure;
    set(0, 'DefaultLineLineWidth', 2);
    plot(t/constants.seconds_per_day, z);
    xlabel('days');
    ylabel('depth (m)');
    set(gca, 'YDir','reverse');
    title(plot_title);
    ylim([0, 80]);
end

function [f, P1] = get_freq_spectrum(t, z, dt_hours)
    % f in day^-1
    Fs = 1/(dt_hours/24);  % sampling frequency (day^-1)
    L = length(t);
    
    Z = fft(z-mean(z));
    P2 = abs(Z/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    f = Fs*(0:(L/2))/L;
end

function plot_freq_spectrum(t, z, dt_hours)
    [f, P1] = get_freq_spectrum(t, z, dt_hours);
    figure; plot(1./f, P1);
    title('Single-Sided Amplitude Spectrum of z(t)');
    xlabel('T (days/cycle)');
    ylabel('|P1(f)|');
    [~, max_i] = max(P1);
    T = 1./f;
    fprintf("Main period: %.0f", T(max_i));
end

function plot_t_vs_rho(t, rho, plot_title)
    figure;
    set(0, 'DefaultLineLineWidth', 2);
    plot(t/constants.seconds_per_day, rho);
    xlabel('days');
    ylabel('densty (kg m^{-3})');
    title(plot_title);
end
