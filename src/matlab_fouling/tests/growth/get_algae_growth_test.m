test_low_temp();
test_high_temp();
test_ok_temp();

disp("All Tests Passed");

%plot_temp_dependency();
%plot_I_dependency();
bernard_fig4();  % not a true confirmation, but reassuring

function bernard_fig4()
    % compare to bernard 2012 fig 4
    p = Particle(NaN, NaN, 1, NaN, NaN, NaN);
    I = 1e-6*[34, 44, 54, 61, 72, 80]; % mol quanta m^-2 s^-1
    T = linspace(kooi_constants.T_min, kooi_constants.T_max);
    figure; hold on;
    max_growth = max(get_algae_growth(p, T, I(6)));
    for i=1:length(I)
        growth = get_algae_growth(p, T, I(i));
        norm_growth = growth/max_growth;
        plot(T, norm_growth, 'DisplayName', sprintf('I: %d', I(i)*1e6));
    end
    legend;
    xlabel('Temperature (C)');
    ylabel('Normalized Growth rate (day^{-1})');
    xlim([-5, 45]);
    ylim([0, 2]);
end

function plot_temp_dependency()
    p = Particle(NaN, NaN, 1, NaN, NaN, NaN);
    T = linspace(kooi_constants.T_min, kooi_constants.T_max, 100);
    I = kooi_constants.I_m;
    
    growth = zeros(100);
    for i=1:100
        growth(i) = get_algae_growth(p, T(i), I);
    end
    plot(T, growth);
    xlabel("T (Celsius)");
    ylabel("Growth (# cells s^{-1})");
end

function plot_I_dependency()
    p = Particle(NaN, NaN, 1, NaN, NaN, NaN);
    T = kooi_constants.T_opt;
    I = linspace(0, kooi_constants.I_m, 100);
    
    growth = zeros(1, 100);
    for i=1:100
        growth(i) = get_algae_growth(p, T, I(i));
    end
    figure;
    plot(I, growth);
    xlabel("I (mol quanta m^{-2} s^{-1})");
    ylabel("Growth (# cells s^{-1})");
end


function test_low_temp()
    p = Particle(NaN, NaN, NaN, NaN, NaN, NaN);
    growth = get_algae_growth(p, kooi_constants.T_min - 1, 0);
    assert_equal(growth, 0);
end

function test_high_temp()
    p = Particle(NaN, NaN, NaN, NaN, NaN, NaN);
    growth = get_algae_growth(p, kooi_constants.T_max + 1, 0);
    assert_equal(growth, 0);
end

function test_ok_temp()
    p = Particle(NaN, NaN, 1, NaN, NaN, NaN);
    growth = get_algae_growth(p, kooi_constants.T_opt, kooi_constants.I_m);
    assert(growth > 0);
end