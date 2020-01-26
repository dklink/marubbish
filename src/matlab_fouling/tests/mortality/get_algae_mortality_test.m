test_location_dependence();
test_algae_count_dependence();

disp("All Tests Passed");

%plot_lat_dependence();
%plot_algae_dependence();

function plot_lat_dependence()
    % to visually confirm dependence
    lat = linspace(-90, 90, 100);
    p = [];
    
    for i = 1: 100
        p = [p Particle(NaN, NaN, 1, lat(i), NaN, NaN)];
    end
    plot(lat, constants.seconds_per_day*arrayfun(@(x) get_algae_mortality(x), p));  % inspect this!
    xlabel("Latitude (deg N)");
    ylabel("Mortality Rate (cells per day)");
end

function plot_algae_dependence()
    % to visually confirm linear relation
    lat = 0;
    num_algae = linspace(1, 1e6, 100);
    p = Particle(NaN, NaN, num_algae, lat, NaN, NaN);

    plot(num_algae, get_algae_mortality(p));  % inspect this!
    xlabel("Number algae cells");
    ylabel("Mortality Rate (cells per second)");
end

function test_location_dependence()
    p1 = Particle(NaN, NaN, 1, 0, NaN, NaN);
    p2 = Particle(NaN, NaN, 1, 90, NaN, NaN);
    assert(get_algae_mortality(p1) > get_algae_mortality(p2));
end

function test_algae_count_dependence()
    ratio = 100;
    lat = 10;
    p1 = Particle(NaN, NaN, 1, lat, NaN, NaN);
    p2 = Particle(NaN, NaN, p1.A*ratio, lat, NaN, NaN);
    
    A = get_algae_mortality(p1);
    B = get_algae_mortality(p2);

    assert_equal(A, B/ratio);
end