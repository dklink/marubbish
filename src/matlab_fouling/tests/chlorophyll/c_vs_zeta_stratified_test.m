Uitz_fig_4b();

function Uitz_fig_4b()
    %replicates Uitz 2006 figure 4b
    zeta = linspace(0, 2, 50);
    marker = {'o', '^', '+', 's', 'd', '^', 'x', 'o', 'd'};
    facecolor = {'k', 'w', 'k', 'k', 'w', 'k', 'k', 'w', 'k'};
    figure; hold on;
    for i=1:9
        plot(c_vs_zeta_stratified(zeta, i), -zeta, ...
                                 ['k' marker{i}], ...
                                 'MarkerFaceColor', facecolor{i}, ...
                                 'DisplayName', sprintf('S%d', i));
    end
    legend();
    xlabel('c(\zeta)');
    ylabel('\zeta');
    title('Uitz fig 4b');
end