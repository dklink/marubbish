disp("All Tests Passed");

sharqawy_fig8();

function sharqawy_fig8()
    % sharqawy 2010 fig8
    S = 0:40:120;
    T = linspace(0, 180);
    
    figure; hold on;
    for i=1:length(S)
        mu_sw = dynamic_viscosity_seawater(S(i), T);
        plot(T, mu_sw*1e3, 'DisplayName', sprintf("S=%d", S(i)));
    end
    legend();
    xlabel("Temperature, ^oC");
    ylabel("Viscosity x 10^3, kg/m.s");
    xlim([0, 200]);
    ylim([0, 2.5]);
end
    