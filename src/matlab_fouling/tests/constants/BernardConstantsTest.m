typo_test();
disp("All Tests Passed");

function typo_test()
    % retype constants straight from Bernard
    K_m = 15.0; % micro mol m^-2 s^-1
    assert_equal(K_m, BernardConstants.K_m*1e6);
    
    mu_max_n_oceanica = 1.85; % day^-1
    assert_equal(mu_max_n_oceanica, BernardConstants.mu_max * constants.seconds_per_day);
end