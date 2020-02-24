%Uitz_4c(); % does quite well 
%Uitz_4d();  % works well after replacing one of Uitz' s params (see note in UitzConstants)
plot_surface_concentration_spectrum();

disp("All Tests Passed");

function Uitz_4c()
    % see how model shapes up against real data in Uitz
    z = linspace(0, 240, 20);
    chl_surf = [.039, .07, .11, .17];  % roughly the surface concentrations in the plot
    
    marker = {'o', '^', '+', 's'};
    facecolor = {'k', 'w', 'k', 'k'};
    figure; hold on;
    for i=1:4
        plot(chl_vs_z_stratified(z, chl_surf(i)), z, ...
                                 ['k--' marker{i}], ...
                                 'MarkerFaceColor', facecolor{i}, ...
                                 'DisplayName', sprintf('S%d', i));
    end
    legend();
    set(gca, 'YDir','reverse');
    xlabel("chlorophyll-a concentration (mg m^{-3})");
    ylabel("z (m)");
    xlim([0, .3]);
end

function Uitz_4d()
    % see how model shapes up against real data in Uitz
    z = linspace(0, 140, 20);
    chl_surf = [.25, .35, .6, 1.1, 2.9];  % roughly the surface concentrations in the plot
    
    marker = {'d', '^', 'x', 'o', 'd'};
    facecolor = {'w', 'k', 'k', 'w', 'k'};
    figure; hold on;
    for i=1:5
        plot(chl_vs_z_stratified(z, chl_surf(i)), z, ...
                                 ['k--' marker{i}], ...
                                 'MarkerFaceColor', facecolor{i}, ...
                                 'DisplayName', sprintf('S%d', i));
    end
    legend();
    set(gca, 'YDir','reverse')
    xlabel("chlorophyll-a concentration (mg m^{-3})");
    ylabel("z (m)");
    xlim([0, 3.5]);
end

function plot_surface_concentration_spectrum()
    z = linspace(0, 200);
    chl_surf = logspace(log10(0.01), log10(10), 100);
    chl = zeros(length(z), length(chl_surf));
    for i=1:length(chl_surf)
        chl(:, i) = chl_vs_z_stratified(z, chl_surf(i));
    end
    chl(chl<1e-2) = 1e-2;
    contourf(chl_surf, z, chl, logspace(log10(1e-2), log10(10), 200), 'Linecolor', 'none');
    set(gca, 'xscale', 'log')
    set(gca,'colorscale','log')
    set(gca,'ydir','reverse');
    c = colorbar();
    c.Label.String = 'algae concentration at depth (mg m^{-3})';
    colormap('winter');
    xlabel('Algae Concentration at Surface (mg m^{-3})');
    ylabel('depth (m)');
    title('Uitz 2006 stratified water algae profile');
end