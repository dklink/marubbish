test_case_1();
test_case_2();
test_case_3();

disp("All Tests Passed");

%plot_profile();

function plot_profile()
    z = linspace(0, 300, 100);
    chl_surf = 1;
    chl_z = zeros(1, 100);
    for i=1:100
        chl_z(i) = get_chl_at_z_mixed(z(i), chl_surf, 100);
    end
    
    plot(chl_z, z);
    set(gca, 'YDir','reverse')
    xlabel("chlorophyll-a concentration (mg m^{-3})");
    ylabel("z (m)");
end

function test_case_1()
    z_eu = 100;
    chl_surf = 1;
    assert_equal(chl_surf, get_chl_at_z_mixed(0, chl_surf, z_eu));
    assert_equal(chl_surf, get_chl_at_z_mixed(z_eu/2, chl_surf, z_eu));
    assert_equal(chl_surf, get_chl_at_z_mixed(z_eu, chl_surf, z_eu));
end

function test_case_2()
    z_eu = 100;
    chl_surf = 1;
    assert_equal(chl_surf/2, get_chl_at_z_mixed(z_eu*1.5, chl_surf, z_eu));
    assert_equal(0, get_chl_at_z_mixed(z_eu*2, chl_surf, z_eu));
end

function test_case_3()
    z_eu = 100;
    chl_surf = 1;
    assert_equal(0, get_chl_at_z_mixed(z_eu*3, chl_surf, z_eu));
end