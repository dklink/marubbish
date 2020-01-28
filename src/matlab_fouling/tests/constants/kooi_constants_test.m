typo_test();
test_r_A();

disp("All Tests Passed");

function typo_test()
    % re-type all the constants
    assert_equal(2726e-9, kooi_constants.carbon_per_algae); % hey, I caught a typo
    assert_equal(1.7e5, kooi_constants.gamma * constants.seconds_per_day);
    assert_equal(1.2e8, kooi_constants.I_m*1e6 * constants.seconds_per_day);
    assert_equal(2, kooi_constants.Q_10);
    assert_equal(.1, kooi_constants.R_A * constants.seconds_per_day);
    assert_equal(1388, kooi_constants.rho_A);
    assert_equal(33.3, kooi_constants.T_max);
    assert_equal(.2, kooi_constants.T_min);
    assert_equal(26.7, kooi_constants.T_opt);
    assert_equal(2e-16, kooi_constants.V_A);
end

function test_r_A()
    r_A = nthroot(3/(4*pi) * kooi_constants.V_A, 3); % invert V = 4/3 pi r^3
    assert_equal(r_A, kooi_constants.r_A);
end