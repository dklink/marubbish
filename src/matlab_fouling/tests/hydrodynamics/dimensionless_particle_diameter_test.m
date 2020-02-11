test_by_hand();
test_always_positive();

disp("All Tests Passed");


function test_by_hand()
    % pen-and-paper confirmation of two values
    rho_1 = 940;
    rho_2 = 1024;
    r_1 = .001;
    r_2 = .1;
    T = 25;
    S = 35;
    seawater_density = get_seawater_density(S, T);  % 1023.561 kg m^-3
    nu_sw = kinematic_viscosity_seawater(S, T);  % 9.367568e-7 m^2 s^-1
    
    A_1 = 7.301215e3;  % calculated by hand
    B_1 = dimensionless_particle_diameter(Particle(r_1, rho_1, 0, 0, 0, 0), S, T);
    assert_equal(A_1*1e-3, B_1*1e-3, 1e-2);  % accurate to 3 significant figures

    A_2 = 3.835801e7;
    B_2 = dimensionless_particle_diameter(Particle(r_2, rho_2, 0, 0, 0, 0), S, T);
    assert_equal(A_2*1e-7, B_2*1e-7, 1e-2);  % accurate to 3 significant figures
end

function test_always_positive()
    % we shouldn't get negative sizes
    p1 = Particle(.001, 940, 0, 0, 0, 10);
    p2 = Particle(.001, 1100, 0, 0, 0, 10);
    T = 20;
    S = 35;
    
    assert(dimensionless_particle_diameter(p1, S, T) > 0);
    assert(dimensionless_particle_diameter(p2, S, T) > 0);
end