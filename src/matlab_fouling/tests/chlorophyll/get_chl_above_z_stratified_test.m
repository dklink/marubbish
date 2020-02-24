test_vs_numeric_integration();

function test_vs_numeric_integration()
    z = linspace(0, 250, 1000);  % m
    chl_surf = 2.524;  % mg m^-3
    chl_z = chl_vs_z_stratified(z, chl_surf);
    
    subplot(1, 2, 1);
    plot(chl_z, z);
    set(gca, 'ydir', 'reverse');
    xlabel('[chl] (mg m^{-3})');
    ylabel('depth (m)');
    xlim([-.1, 2.1]);
    
    chl_tot_coarse = get_chl_above_z_stratified(z, chl_surf);
    chl_tot_fine = zeros(1, length(chl_tot_coarse));
    for i=2:length(chl_tot_fine)
        chl_tot_fine(i) = trapz(z(1:i), chl_z(1:i));
    end
    
    subplot(1, 2, 2); hold on;
    plot(chl_tot_coarse, z, 'DisplayName', 'coarse numeric integration');
    plot(chl_tot_fine, z, 'DisplayName', 'fine numeric integration');
    legend();
    set(gca, 'ydir', 'reverse');
    xlabel('[chl tot] (mg m^{-2})');
    ylabel('depth (m)');
    xlim([-8, 150]);

end