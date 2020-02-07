test_max();
test_min();
test_opt();
test_equation();
disp("All Tests Passed");

plot_T_dependency();  % looks good

function plot_T_dependency()
    T = linspace(kooi_constants.T_min-1, kooi_constants.T_max+.5, 100);
    scaling_factor = temperature_influence_on_algae_growth(T); 
    plot(T, scaling_factor);
    xlabel("T (Celsius)");
    ylabel("Algal Growth Scaling Factor");
    xline(kooi_constants.T_max, '-', 'T_{max}');
    xline(kooi_constants.T_min, '-', 'T_{min}');
    xline(kooi_constants.T_opt, '-', 'T_{opt}');
end

function test_min()
    A = temperature_influence_on_algae_growth(kooi_constants.T_min);
    assert_equal(A, 0);
end

function test_max()
    A = temperature_influence_on_algae_growth(kooi_constants.T_max);
    assert_equal(A, 0);
end

function test_opt()
    T = linspace(kooi_constants.T_min-1, kooi_constants.T_max+.5, 1000);
    scaling_factor = temperature_influence_on_algae_growth(T); 
    [~, max_id] = max(scaling_factor);
    assert_equal(T(max_id), kooi_constants.T_opt, .01);
end

function test_equation()
    T_max = kooi_constants.T_max;
    T_min = kooi_constants.T_min;
    T_opt = kooi_constants.T_opt;
    
    T_z = 25;
    
    A = ((T_z - T_max)*(T_z-T_min)^2)/((T_opt-T_min)*((T_opt-T_min)*(T_z-T_opt)-(T_opt-T_max)*(T_opt+T_min-2*T_z)));
    B = temperature_influence_on_algae_growth(T_z);
    
    assert_equal(A, B);
end