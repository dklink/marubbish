test_typos();
test_always_positive();

disp("All Tests Passed");

function test_typos()
    % retype from Kooi eq. 4
    p = Particle(.001, 940, 1e7, 0, 0, 10);
    T = 20;
    S = 35;
    
    rho_sw = get_seawater_density(S, T, p.lat, p.lon, p.z);
    nu_sw = kinematic_viscosity_seawater(S, T, rho_sw);
    
    A = (p.rho_tot - rho_sw)*constants.g*p.D_n^3 / (rho_sw*nu_sw^2);
    B = dimensionless_particle_diameter(p, S, T);
    
    assert_equal(A, B);
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