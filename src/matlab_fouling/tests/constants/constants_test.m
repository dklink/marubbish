typo_check();

disp("All Tests Passed");

function typo_check()
    assert_equal(constants.arctic_circle_lat, 66.5);
    assert_equal(constants.subtropical_lat_max, 35);
    assert_equal(constants.g, 9.81);
    assert_equal(constants.k, 1.380649e-23);
    assert_equal(constants.seconds_per_day, 86400);
end