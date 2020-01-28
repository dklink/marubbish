test_typos();
test_no_algae_floats();
test_much_algae_sinks();
disp("All Tests Passed");

%plot_algae_dependency(1, 1e7); % shows linear behavior in "small" quantities
%plot_algae_dependency(1, 1e11); % shows whole behavior, fast growth-ish
%plot_d_star(1e9, 1e10); % highlights small discontinuity due to omega_star definition
                                    %(kooi_constants.omega_star)

function plot_algae_dependency(min_A, max_A)
    A = logspace(log10(min_A), log10(max_A), 100);
    p = [];
    T = 20;
    S = 35;
    V_s = zeros(1, 100);
    d_star = zeros(1, 100);
    r_tot = zeros(1, 100);
    for i=1:100
        p = [p Particle(.001, 940, A(i), 0, 0, 10)];
        d_star(i) = kooi_constants.dimensionless_particle_diameter(p(i), S, T);
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
        d_star(i) = kooi_constants.dimensionless_particle_diameter(p(i), S, T);
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
    p = Particle(.001, 940, 1e15, 0, 0, 10);
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
        kooi_constants.omega_star(p, S, T) * kinematic_viscosity_seawater(S, T, rho_sw), 3);
    
    B = get_settling_velocity(p, S, T);

    assert_equal(A, B);
end