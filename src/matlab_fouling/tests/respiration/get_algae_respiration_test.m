test_respiration_temp_dependence();  % doubles every 10 deg C
test_respiration_algae_count_dependence();  % linear with A

disp("All Tests Passed");

plot_temp_dependence();
%plot_algae_dependence();

function plot_temp_dependence()
    % to visually confirm relation
    T = linspace(kooi_constants.T_min, kooi_constants.T_max, 100);
    p = Particle(NaN, NaN, 1, NaN, NaN, NaN);

    plot(T, get_algae_respiration(p, T));  % inspect this!
    xlabel("Temperature (C)");
    ylabel("Respiration Rate");
end

function plot_algae_dependence()
    % to visually confirm relation
    T = 30;
    num_algae = linspace(1, 1e6, 100);
    p = Particle(NaN, NaN, num_algae, NaN, NaN, NaN);

    plot(num_algae, get_algae_respiration(p, T));  % inspect this!
    xlabel("Number algae cells");
    ylabel("Respiration Rate");
end

function test_respiration_temp_dependence()
    p = Particle(NaN, NaN, 0, NaN, NaN, NaN);

    A = get_algae_respiration(p, 30);
    B = get_algae_respiration(p, 20);
    
    assert_equal(A, 2*B);
end

function test_respiration_algae_count_dependence()
    ratio = 100;
    temp = 30;
    p1 = Particle(NaN, NaN, 1, NaN, NaN, NaN);
    p2 = Particle(NaN, NaN, p1.A*ratio, NaN, NaN, NaN);
    
    A = get_algae_respiration(p1, temp);
    B = get_algae_respiration(p2, temp);

    assert_equal(A, B/ratio);
end