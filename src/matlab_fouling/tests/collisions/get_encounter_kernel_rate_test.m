test_sanity();

disp("All Tests Passed");

function test_sanity()
    % not sure what to test other than just retyping everyting to catch
    % typos
    particle = Particle(.001, 940, 1e7, 0, 0, 10); % enough algae for a bit of biofilm
    T = 20;
    S = 35;
    
    k = constants.k;
    mu_sw = dynamic_viscosity_seawater(S, T);
    r_tot = particle.r_tot;
    r_A = kooi_constants.r_A;
    V_s = get_settling_velocity(particle, S, T);
    gamma = kooi_constants.gamma;
    
    
    D_pl = k * (T + 273.16) / (6*pi*mu_sw*r_tot);
    D_A = k * (T + 273.16) / (6*pi*mu_sw*r_A);
    
    Beta_A_brownian = 4*pi*(D_pl + D_A) * (r_tot + r_A);
    Beta_A_settling = .5*pi*r_tot^2 * V_s;
    Beta_A_shear = 1.3*gamma*(r_tot + r_A)^3;
    
    A = Beta_A_brownian + Beta_A_settling + Beta_A_shear;
    B = get_encounter_kernel_rate(particle, S, T);
    
    assert_equal(A, B);
end