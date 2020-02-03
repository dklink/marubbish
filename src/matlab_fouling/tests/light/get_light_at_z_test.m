sanity_check();

disp("All Tests Passed")

plot_z_dependence();  

function plot_z_dependence()
    z = linspace(0, 50);
    chl_ave = .05;  % varying this basically has no effect
    I_surf = kooi_constants.I_m;
    
    I_z = get_light_at_z(z, I_surf, chl_ave);
    
    plot(I_z, z);
    set(gca, 'YDir','reverse')
    xline(I_surf/100);
    xlabel("light intensity (mol quanta m^-2 s^-1)");
    ylabel("depth (m)");
end

function sanity_check()
    I_surf = kooi_constants.I_m;
    assert_equal(get_light_at_z(0, I_surf, 1), I_surf);
    assert_equal(get_light_at_z(500, I_surf, 1), 0, 1e-8);  % no light at 500m
end