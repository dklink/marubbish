Jackson_fig1a();

function Jackson_fig1a()
    % replicate fig1a from Jackson 1990
    % depends on what Jackson used as min. r, but looks right.
    
    r = 1e-6*linspace(.3, 50);  % m . changing the min value here fucks with the graph a lot
    [X, Y] = meshgrid(r*1e6, r*1e6);
    
    p = Particle(r, 0, 0, 0, 0, 0);  % model an algae cell.
    S = 35; T = 25;
    BETA = zeros(length(r), length(r));
    for i=1:length(r)
        BETA(i, :) = brownian_encounter_rate(p, S, T, r(i))*100^3;  % convert m^3 to cm^3
    end
    surf(X, Y, BETA);
    xlabel('r_i (\mum)');
    ylabel('r_i (\mum)');
    zlabel('Beta_brownian (cm^3 s^-1)');
    xlim([0, 50]);
    ylim([0, 50]);
    zlim([0, 5e-10]);
end