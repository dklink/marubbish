Jackson_fig1d();

function Jackson_fig1d()
    % replicate fig1d from Jackson 1990
    % should be vaguely cubic looking.  Hard to tell but seems ok.
    
    r = 1e-6*linspace(.1, 50);  % m
    p = Particle(r, 0, 0, 0, 0, 0);
    beta = shear_encounter_rate(p);
    figure;
    plot(r*1e6, beta * 100e3); % convert m^3 to cm^3
    xlabel('r (\mum)');
    ylabel('Beta_shear (cm^3 s^-1)');
    xlim([0, 50]);
    ylim([0, 8e-7]);
    title(sprintf('r_A=%.1f \\mum', kooi_constants.r_A*1e6));
end