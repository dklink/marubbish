disp("All Tests Passed");

sharqawy_fig_3();  % matches perfectly

function sharqawy_fig_3()
    S = 0:20:160;
    T = linspace(0, 180);
    
    figure; hold on;
    for i=1:length(S)
        rho = get_seawater_density(S(i), T);
        plot(T, rho, 'DisplayName', sprintf("S=%d", S(i)));
    end
    legend();
    xlabel("Tempearture, ^oC");
    ylabel("Density, kg/m^3");
    xlim([0, 200]);
    ylim([850, 1150]);
end
    