test_small_D_star();
test_larger_D_star();
test_too_large_D_star();

disp("All Tests Passed");

plot_dietrich_fig1();

function test_small_D_star()
    % kooi 2017 eq. 3 case 1
    % caught a damn typo!
    p = Particle(1e-6, 940, 0, 0, 0, 10);
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
    p = Particle(.01, 940, 0, 0, 0, 10);  % big particle boi
    S = 35;
    T = 20;
    
    d_star = dimensionless_particle_diameter(p, S, T);
    assert(d_star > .05);
    assert(d_star < 5e9);
    
    A = 10^(-3.76715+1.92944*log10(d_star) - .09815*log10(d_star)^2.0 - ...
        .00575*log10(d_star)^3.0 + .00056*log10(d_star)^4.0);
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

function plot_dietrich_fig1()
    % visually confirm plot matches dietrich 1982 fig1
    % by generating a bunch of random particles in reasonable size/density range
    r_max = 1e-2;
    r_min = 1e-9;
    rho_max = kooi_constants.rho_A;
    rho_min = kooi_constants.rho_PP;
    nsamples = 1000;
    
    omega_star = ones(1, nsamples);
    d_star = ones(1, nsamples);
    
    S = 35;
    T = 25;
    for i=1:nsamples
        r = exp((log(r_max)-log(r_min))*rand(1, 1) + log(r_min));
        rho = (rho_max-rho_min)*rand(1, 1) + rho_min;
        p = Particle(r, rho, 0, 0, 0, 10);
        d_star(i) = dimensionless_particle_diameter(p, S, T);
        omega_star(i) = dimensionless_settling_velocity(p, S, T);
    end
    figure();
    plot(d_star, omega_star, '.');
    set(gca,'Xscale','log');
    set(gca,'Yscale','log');
    xlim([1e-2, 1e10]);
    ylim([1e-6, 1e6]);
    xlabel('D_*');
    ylabel('w_*');
end