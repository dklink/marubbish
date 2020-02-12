test_sanity();

disp("All Tests Passed");

Jackson_fig1d();

function Jackson_fig1d()
    % replicate fig1b from Jackson 1990
    % hard to tell exact values, but looks about correct!  Depends on the
    % particle density chosen.
    
    r = 1e-6*linspace(.1, 50);  % m . changing the min value here fucks with the graph a lot
    p = Particle(r, 1050, 0, 0, 0, 0);  % model an algae cell.
    V_s = get_settling_velocity(p, 35, 25);
    S = 35; T = 25;
    BETA = zeros(1, length(r));
    for i=1:length(r)
        p = Particle(r(i), 1050, 0, 0, 0, 0);  % model an algae cell.
        BETA(i) = 100e3*(brownian_encounter_rate(p, S, T) + ...
                            settling_encounter_rate(p, V_s(i)) + ...
                            shear_encounter_rate(p));   
    end
    figure;
    plot(r*1e6, BETA);
    xlabel('r (\mum)');
    ylabel('Beta_total (cm^3 s^-1)');
    xlim([0, 50]);
    ylim([0, 8e-7]);
end

function test_sanity()
    % not sure how to test other than just retyping everyting to try and catch
    % typos
    particle = Particle(.001, 940, 1e7, 0, 0, 10); % enough algae for a bit of biofilm
    T = 20;
    S = 35;
    
    k = constants.k;
    mu_sw = dynamic_viscosity_seawater(S, T);
    r_tot = particle.r_tot;
    r_A = kooi_constants.r_A;
    V_s = abs(get_settling_velocity(particle, S, T));
    gamma = kooi_constants.gamma;
    
    
    D_pl = k * (T + 273.16) / (6*pi*mu_sw*r_tot);
    D_A = k * (T + 273.16) / (6*pi*mu_sw*r_A);
    
    Beta_A_brownian = 4*pi*(D_pl + D_A) * (r_tot + r_A);
    Beta_A_settling = .5*pi*r_tot^2 * V_s;
    Beta_A_shear = 1.3*gamma*(r_tot + r_A)^3;
    
    A = Beta_A_brownian + Beta_A_settling + Beta_A_shear
    B = get_encounter_kernel_rate(particle, S, T)
    
    assert_equal(A, B);
end