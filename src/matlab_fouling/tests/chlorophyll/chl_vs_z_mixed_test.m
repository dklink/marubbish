%Uitz_5b();  eh... it's ok
%Uitz_5c();  eh... it's ok
plot_surface_concentration_spectrum();

disp("All Tests Passed");

function Uitz_5b()
    % see how model shapes up against real data in Uitz
    z = linspace(0, 140, 20);
    chl_surf = [.22, .61, .9];  % roughly the surface concentrations in the plot
    
    marker = {'o', '^', '+'};
    facecolor = {'k', 'w', 'k'};
    figure; hold on;
    for i=1:3
        plot(chl_vs_z_mixed(z, chl_surf(i)), z, ...
                             ['k--' marker{i}], ...
                             'MarkerFaceColor', facecolor{i}, ...
                             'DisplayName', sprintf('S%d', i));
    end
    legend();
    set(gca, 'YDir','reverse');
    xlabel("chlorophyll-a concentration (mg m^{-3})");
    ylabel("z (m)");
    xlim([0, 1]);
end

function Uitz_5c()
    % see how model shapes up against real data in Uitz
    z = linspace(0, 70, 20);
    chl_surf = [1.8, 4.8];  % roughly the surface concentrations in the plot
    
    marker = {'s', 'd'};
    facecolor = {'k', 'w'};
    figure; hold on;
    for i=1:2
        plot(chl_vs_z_mixed(z, chl_surf(i)), z, ...
                             ['k--' marker{i}], ...
                             'MarkerFaceColor', facecolor{i}, ...
                             'DisplayName', sprintf('S%d', i));
    end
    legend();
    set(gca, 'YDir','reverse');
    xlabel("chlorophyll-a concentration (mg m^{-3})");
    ylabel("z (m)");
    xlim([0, 6]);
end

function plot_surface_concentration_spectrum()
    z = linspace(0, 200);
    chl_surf = logspace(log10(0.01), log10(10), 100);
    chl = zeros(length(z), length(chl_surf));
    for i=1:length(chl_surf)
        chl(:, i) = chl_vs_z_mixed(z, chl_surf(i));
    end
    chl(chl<1e-2) = 1e-2;
    figure;
    contourf(chl_surf, z, chl, logspace(log10(1e-2), log10(10), 200), 'Linecolor', 'none');
    set(gca, 'xscale', 'log')
    set(gca,'colorscale','log')
    set(gca,'ydir','reverse');
    c = colorbar();
    c.Label.String = 'algae concentration at depth (mg m^{-3})';
    colormap('winter');
    xlabel('Algae Concentration at Surface (mg m^{-3})');
    ylabel('depth (m)');
    title('Uitz 2006 mixed water algae profile');
end