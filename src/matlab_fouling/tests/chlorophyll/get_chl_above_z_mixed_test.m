test_vs_numeric_integration();

function test_vs_numeric_integration()
    z = linspace(0, 150);  % m
    chl_surf = 2.524;  % mg m^-3
    chl_z = chl_vs_z_mixed(z, chl_surf);
    
    subplot(1, 2, 1);
    plot(chl_z, z);
    set(gca, 'ydir', 'reverse');
    xlabel('[chl] (mg m^{-3})');
    ylabel('depth (m)');
    xlim([-.1, 2.1]);
    
    chl_tot_sym = get_chlorophyll_above_z_mixed(z, chl_surf);
    chl_tot_num = zeros(1, length(chl_tot_sym));
    for i=2:length(chl_tot_num)
        chl_tot_num(i) = trapz(z(1:i), chl_z(1:i));
    end
    
    subplot(1, 2, 2); hold on;
    plot(chl_tot_sym, z, 'DisplayName', 'symbolic integration');
    plot(chl_tot_num, z, 'DisplayName', 'numeric integration');
    legend();
    set(gca, 'ydir', 'reverse');
    xlabel('[chl tot] (mg m^{-2})');
    ylabel('depth (m)');
    xlim([-8, 150]);

end