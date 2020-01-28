typo_test();
zone_test();
disp("All Tests Passed");

function zone_test()
    assert_equal(CalbetConstants.getAlgaeMortality(0), CalbetConstants.tropical_mortality);
    assert_equal(CalbetConstants.getAlgaeMortality(50), CalbetConstants.temperate_mortality);
    assert_equal(CalbetConstants.getAlgaeMortality(80), CalbetConstants.polar_mortality);
end

function typo_test()
    % retyped from Calbet 2004
    polar_m = .16; % day ^-1
    tropical_m = .50; % day^-1
    temperate_m = .41; % day^-1
    
    assert_equal(polar_m, CalbetConstants.polar_mortality * constants.seconds_per_day);
    assert_equal(tropical_m, CalbetConstants.tropical_mortality * constants.seconds_per_day);
    assert_equal(temperate_m, CalbetConstants.temperate_mortality * constants.seconds_per_day);
end