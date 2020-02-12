% seems ok, can't find any other papers using a hill function for this though
first_100m();
whole_profile(); 

function first_100m()
    figure;
    z = linspace(0, 100);
    plot(T_vs_z(z), z);
    set(gca, 'YDir', 'reverse');
    xlabel('Temperature (C)');
    ylabel('depth (m)');
end

function whole_profile()
    figure;
    z = linspace(0, 8000, 1000);
    plot(T_vs_z(z), z);
    set(gca, 'YDir', 'reverse');
    xlabel('Temperature (C)');
    ylabel('depth (m)');
end