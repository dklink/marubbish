test_low_temp();
test_high_temp();
test_ok_temp();

disp("All Tests Passed");

%plot_temp_dependency();
%plot_I_dependency();

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
    I = linspace(0, kooi_constants.I_m*2, 100);
    
    growth = zeros(100);
    for i=1:100
        growth(i) = get_algae_growth(p, T, I(i));
    end
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