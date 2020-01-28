test_small_D_star();
test_larger_D_star();
test_too_large_D_star();

disp("All Tests Passed");

function test_small_D_star()
    % kooi 2017 eq. 3 case 1
    % caught a damn typo!
    p = Particle(.001, 940, 0, 0, 0, 10);
    S = 35;
    T = 20;
    
    d_star = dimensionless_particle_diameter(p, S, T);
    assert(d_star < .05);
    
    A = 1.74e-4 * d_star^2;
    B = dimensionless_settling_velocity(p, S, T);
    assert_equal(A, B);
end

function test_larger_D_star()
    % kooi 2017 eq. 3 case 2
    p = Particle(.1, 940, 0, 0, 0, 10);  % big particle boi
    S = 35;
    T = 20;
    
    d_star = dimensionless_particle_diameter(p, S, T);
    assert(d_star > .05);
    assert(d_star < 5e9);
    
    A = exp(-3.76715+1.92944*log(d_star) - .09815*log(d_star)^2.0 - ...
        .00575*log(d_star)^3.0 + .00056*log(d_star)^4.0);
    B = dimensionless_settling_velocity(p, S, T);
    assert_equal(A, B);
end

function test_too_large_D_star()
% kooi 2017 eq. 3 case 3, make sure we error
    p = Particle(100, 940, 0, 0, 0, 10);  % immense particle boi
    S = 35;
    T = 20;
    
    d_star = dimensionless_particle_diameter(p, S, T);
    assert(d_star > 5e9);
    
    try
        dimensionless_settling_velocity(p, S, T);
        assert(false);
    catch
        assert(true);
    end
end
