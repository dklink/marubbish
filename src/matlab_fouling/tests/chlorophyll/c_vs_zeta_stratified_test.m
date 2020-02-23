Uitz_fig_4b();

function Uitz_fig_4b()
    %replicates Uitz 2006 figure 4b
    chl_surf = [0, .06, .10, .15, .25, .35, .5, .9, 3];  % all 9 concentration classes
    zeta = linspace(0, 2, 50);
    marker = {'o', '^', '+', 's', 'd', '^', 'x', 'o', 'd'};
    facecolor = {'k', 'w', 'k', 'k', 'w', 'k', 'k', 'w', 'k'};
    figure; hold on;
    for i=1:length(chl_surf)
        plot(c_vs_zeta_stratified(zeta, chl_surf(i)), -zeta, ...
                                 ['k' marker{i}], ...
                                 'MarkerFaceColor', facecolor{i}, ...
                                 'DisplayName', sprintf('S%d', i));
    end
    legend();
    xlabel('c(\zeta)');
    ylabel('\zeta');
    title('Uitz fig 4b');
end