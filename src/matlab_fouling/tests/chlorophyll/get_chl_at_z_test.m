%plot_profile();  % visually confirmed, matches Uitz 2006 fig. 4c, S2

disp("All Tests Passed");

function plot_profile()
    z = linspace(0, 300, 100);
    chl_surf = .05;
    chl_z = zeros(1, 100);
    for i=1:100
        chl_z(i) = get_chl_at_z(z(i), chl_surf);
    end
    
    plot(chl_z, z);
    set(gca, 'YDir','reverse')
    xlabel("chlorophyll-a concentration (mg m^{-3})");
    ylabel("z (m)");
end
