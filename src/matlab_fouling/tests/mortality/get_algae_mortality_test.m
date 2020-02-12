test_sanity();
disp("All Tests Passed");

function test_sanity()
    p = Particle(0, 0, 1, 0, 0, 0);
    
    A = .39;  % algae cells m^-2 day^-1
    B = get_algae_mortality(p) * constants.seconds_per_day;
    assert_equal(A, B);

    p = Particle(0, 0, 100, 0, 0, 0);
    A = 39;  % algae cells m^-2 day^-1
    B = get_algae_mortality(p) * constants.seconds_per_day;
    assert_equal(A, B);
end