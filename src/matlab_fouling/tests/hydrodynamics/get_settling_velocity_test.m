test_typos();
test_no_algae_floats();
test_much_algae_sinks();
test_surface_constraint();
%test_kowalski_table2();
disp("All Tests Passed");

%plot_algae_dependency(1, 1e7); % shows linear behavior in "small" quantities
%plot_algae_dependency(1, 1e11); % shows whole behavior, fast growth-ish
%plot_d_star(1e9, 1e10); % highlights small discontinuity due to omega_star definition
                                    %(kooi_constants.omega_star)
%kowalski_fig2();
%kowalski_fig3();
kowalski_fig4();

function plot_algae_dependency(min_A, max_A)
    A = logspace(log10(min_A), log10(max_A), 100);
    p = [];
    T = 20;
    S = 35;
    V_s = zeros(1, 100);
    r_tot = zeros(1, 100);
    for i=1:100
        p = [p Particle(.001, 940, A(i), 0, 0, 10)];
        V_s(i) = get_settling_velocity(p(i), S, T);
        r_tot(i) = p(i).r_tot;
    end
    
    figure();
    semilogx(A, V_s);
    xlabel("number algae particles");
    ylabel("settling velocity");
    
    figure()
    semilogx(r_tot, V_s);
    xlabel("total particle radius (m)");
    ylabel("settling velocity");

end

function plot_d_star(min_A, max_A)
    A = logspace(log10(min_A), log10(max_A), 100);
    p = [];
    T = 20;
    S = 35;
    V_s = zeros(1, 100);
    d_star = zeros(1, 100);
    r_tot = zeros(1, 100);
    for i=1:100
        p = [p Particle(.001, 940, A(i), 0, 0, 10)];
        d_star(i) = dimensionless_particle_diameter(p(i), S, T);
        V_s(i) = get_settling_velocity(p(i), S, T);
        r_tot(i) = p(i).r_tot;
    end
    
    figure()
    semilogx(d_star, V_s);
    xlabel("dimensionless particle diameter");
    xline(.05, '-', "d_* = .05");
    ylabel("settling velocity");
    
    figure()
    semilogx(r_tot, V_s);
    xlabel("total particle radius (m)");
    ylabel("settling velocity");
end

function test_no_algae_floats ()
    p = Particle(.001, 940, 0, 0, 0, 10);
    T = 20;
    S = 35;
    V_s = get_settling_velocity(p, S, T);
    assert(V_s < 0);
end

function test_much_algae_sinks ()
    p = Particle(.001, 940, 1e12, 0, 0, 10);
    T = 20;
    S = 35;
    V_s = get_settling_velocity(p, S, T);
    assert(V_s > 0);
end

function test_typos ()
    % retyping the formula to check for errors
    p = Particle(.001, 940, 1e7, 0, 0, 10); % enough algae for a bit of biofilm
    T = 20;
    S = 35;
    
    rho_sw = get_seawater_density(S, T, p.lat, p.lon, p.z);
    
    A = 1 * nthroot((p.rho_tot - rho_sw)/rho_sw * constants.g * ...
        dimensionless_settling_velocity(p, S, T) * kinematic_viscosity_seawater(S, T), 3);
    
    B = get_settling_velocity(p, S, T);

    assert_equal(A, B);
end

function test_surface_constraint()
    p = Particle(.001, 940, 0, 0, 0, 0);  %buoyant at surface
    T = 20;
    S = 35;
    V_s = get_settling_velocity(p, S, T);
    assert(V_s == 0);
end

function kowalski_fig2()
    % from kowalski 2016
    % kowalski uses a set water density, versus ours from S/T
    T = 20; % C, from kowalski table 2
    ESD = linspace(.1, 4);   %mm
    r = .5e-3*ESD; %m
    S = [0, 15, 36];   %g/kg
    rho = 1050;  % kg m^-3
    
    figure; hold on;
    for i=1:length(S)
        V_s = zeros(1, length(r));
        for j=1:length(r)
            p = Particle(r(j), rho, 0, 0, 0, 0);
            V_s(j) = get_settling_velocity(p, S(i), T);
        end
        plot(ESD, V_s, 'DisplayName', sprintf("S=%d", S(i)));
    end
    legend();
    xlabel("ESD [mm]");
    ylabel("Sinking Velocity V_s [ms^{-1}]");
    xlim([0, 4]);
    ylim([0, .05]);
    
end

function test_kowalski_table2()
    rho = 1050;  % kg m^-3
    ESD = [.5, .5, .5, 2, 2, 2];  % mm
    r = .5e-3*ESD;  % m
    S = [0, 15, 36, 0, 15, 36];  % g / kg
    T = [19.3, 19.8, 20.0, 19.7, 20.6, 20.5];  % C
    V_s = 1e-3 * [4.9, 3.9, 2.4, 30, 25, 17]; % m s^-1
    for i=2:6
        p = Particle(r(i), rho, 0, 0, 0, 0);
        A = V_s(i)
        B = get_settling_velocity(p, S(i), T(i))
        tolerance = A*.02;  % accurate to 2%
        assert_equal(A, B, tolerance);
    end
end

function kowalski_fig3()
    % from kowalski 2016
    % this doesn't match perfectly, but I think the lines in his fig3 are
    % best-fit from data, not simulation.  Graph doesn't say.
    T = linspace(17, 23); % C, from kowalski table 2
    ESD = [.5, 2];   %mm
    r = .5e-3*ESD; %m
    S = [0, 15, 36];   %g/kg
    rho = 1050;  % kg m^-3
    ylims = [0, .008; 0, .04];
    figure('Renderer', 'painters', 'Position', [100, 200, 1200, 400]);
    for i=1:2
        subplot(1, 2, i); hold on;
        for j=1:length(S)
            V_s = zeros(1, length(T));
            for k=1:length(T)
                p = Particle(r(i), rho, 0, 0, 0, 0);
                V_s(k) = get_settling_velocity(p, S(j), T(k));
            end
            plot(T, V_s, 'DisplayName', sprintf("S=%d", S(j)));
        end
        legend();
        xlabel("Temperature [^oC]");
        ylabel("Sinking Velocity V_s [ms^{-1}]");
        xlim([17, 23]);
        ylim(ylims(i, :));
        title(sprintf("ESD %.1f mm", ESD(i)));
    end
    
end

function kowalski_fig4()
    % from kowalski 2016
    % this doesn't match perfectly, but I think the lines in his fig3 are
    % best-fit from data, not simulation.  Graph doesn't say.
    T = 20; % C, from kowalski table 2
    ESD = linspace(.1, 4);   %mm
    r = .5e-3*ESD; %m
    S = [0, 15, 36];   %g/kg
    rho = [1050, 1140, 1190, 1390, 1420, 1560];  % kg m^-3
    ylims = [.05, .15*ones(1, 5)];
    figure('Renderer', 'painters', 'Position', [300, 0, 800, 800]);
    for i=1:length(rho)
        subplot(3, 2, i); hold on;
        for j=1:length(S)
            V_s = zeros(1, length(r));
            for k=1:length(r)
                p = Particle(r(k), rho(i), 0, 0, 0, 0);
                V_s(k) = get_settling_velocity(p, S(j), T);
            end
            plot(ESD, V_s, 'DisplayName', sprintf("S=%d", S(j)));
        end
        legend();
        xlabel("ESD [mm]");
        ylabel("Sinking Velocity V_s [ms^{-1}]");
        xlim([0, 4]);
        ylim([0, ylims(i)]);
        title(sprintf("rho %d kg/m^3", rho(i)));
    end
    
end