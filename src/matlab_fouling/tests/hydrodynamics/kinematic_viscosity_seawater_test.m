disp("All Tests Passed");

IITC_7p5_fig3a();

function IITC_7p5_fig3a()
    % compare my viscosity to figure 3.a here: https://ittc.info/media/4048/75-02-01-03.pdf
    % just to check things seem reasonable (note y-axis scale on fig3a is confusing)
    S = [35.16504, 0]; % g/kg
    T = linspace(0, 50);  % deg C
    
    figure; hold on;
    for i=1:length(S)
        nu_sw = kinematic_viscosity_seawater(S(i), T);
        plot(T, nu_sw*1e6, 'DisplayName', sprintf("S=%f", S(i)));
    end
    legend();
    xlabel("Temperature, ^oC");
    ylabel("Kinematic Viscosity, nu * 10^6 (m^2 / s)");
    xlim([0, 50]);
    ylim([.4, 2.0]);
end