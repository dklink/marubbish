Jackson_fig1b();

function Jackson_fig1b()
    % replicate fig1b from Jackson 1990
    % shape is right, at least on the r_i side, which is all we care about
    % as for the values themselves, no idea.
    
    r = 1e-6*linspace(.1, 50);  % m . changing the min value here fucks with the graph a lot
    [X, Y] = meshgrid(r*1e6, r*1e6);
    p = Particle(r, 1024, 0, 0, 0, 0);  % model an algae cell.
    V_s = get_settling_velocity(p, 35, 25);
    V_S = abs(ones(length(V_s), 1)*V_s - transpose(V_s)*ones(1, length(V_s)));
    S = 35; T = 25;
    BETA = zeros(length(r), length(r));
    for i=1:length(r)
        for j=1:length(r)
            p = Particle(r(i), 0, 0, 0, 0, 0);
            BETA(i, j) = settling_encounter_rate(p, V_S(i, j))*100^3;
        end
    end
    surf(X, Y, BETA);
    xlabel('r_i (\mum)');
    ylabel('r_j (\mum)');
    zlabel('Beta_brownian (cm^3 s^-1)');
    xlim([0, 50]);
    ylim([0, 50]);
    zlim([0, 1e-8]);
end