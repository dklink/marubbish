disp("All Tests Passed")

%plot_z_dependence();  
plot_chl_dependence();

%Robson_fig1();  % vertical scale is off by factor of 2, but this is within
                    % reason considering I have no idea how close kooi's 
                    % noon surface irradiance is to Robson's.

function Robson_fig1()
    % Robson 2005, fig1 is a byproduct of light vs z
    day = linspace(1, 5);
    I_0 = I_vs_time(day*constants.seconds_per_day);
    chl_ave = 20 * 1e-3; % mg / L to kg / m^-3, vaguely from another Robson figure
    z = 5; %m
    k_d = kooi_constants.eps_w + kooi_constants.eps_p*chl_ave; % m^-1
    I_ave = (I_0 - get_light_at_z(z, I_0, chl_ave)) / (k_d * z);
    figure;
    plot(day, I_ave*1e6);  % micro mol quanta m^-2 s^-1
    xlabel('time (days');
    ylabel('ave PAR (micro mol quanta m^{-2} s^{-1}');
end

function plot_z_dependence()
    z = linspace(0, 200);
    chl_ave = kooi_constants.chl_ave_np;
    I_surf = kooi_constants.I_m;
    
    I_z = get_light_at_z(z, I_surf, chl_ave);
    
    figure;
    plot(I_z, z);
    xline(I_surf/100, 'DisplayName', '1% surface light');
    yline(min(z(I_z < I_surf/100)), 'DisplayName', 'Euphotic Depth');
    legend();
    set(gca, 'YDir','reverse')
    xlabel("light intensity (mol quanta m^{-2} s^{-1})");
    ylabel("depth (m)");
end

function plot_chl_dependence()
    I_surf = kooi_constants.I_m;
    legend();
    z = linspace(0, 150);
    chl = 1e-6*linspace(0, 10, 6); %kg m^-3, .001-60 typical ocean variation
   
    Z_eu = zeros(length(chl));
    figure; hold on;
    for i=1:length(chl)
        I_z = get_light_at_z(z, I_surf, chl(i));
        plot(I_z, z, 'DisplayName', sprintf('chl: %.3f mg m^-3', chl(i)*1e6));
        yl = yline(min(z(I_z < I_surf/100)));
        set(get(get(yl,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    end
    xline(I_surf/100, 'DisplayName', '1% surface light');
    xlabel("light intensity (mol quanta m^{-2} s^{-1})");
    ylabel("depth (m)");
    set(gca, 'YDir','reverse')
    legend('Location','southeast')
end