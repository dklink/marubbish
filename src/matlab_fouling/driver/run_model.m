% startup parameters
t = datetime(2015, 1, 1, 0, 0, 0):hours(.25*pi):datetime(2016, 1, 1, 0, 0, 0);
r_pl = 50 * 1e-3;  % m
rho_pl = kooi_constants.rho_HDPE;
do_growth_balance_analysis = false;
show_daily_euphotic_depth = false;

[lat, lon] = click_for_coordinates();
p = Particle(r_pl, rho_pl, 0, lat, lon, 0);

disp('Input parameters:');
fprintf('[lat, lon] = [%.3f, %.3f]\n', lat, lon);
fprintf('Particle radius: %.01g mm\n', p.r_pl*1e3);
fprintf('Particle density: %d kg m^-3\n', p.rho_pl);
fprintf('Time start, stop, step: %s, %s, %.2f hours\n', datestr(t(1)), datestr(t(end)), hours(t(2)-t(1)));
disp(['Salinity forcing: ' Paths.salinity]);
disp(['Temperature forcing: ' Paths.temperature]);
disp(['Surface Chlorophyll forcing: ' Paths.chlorophyll]);

disp('Beginning model run...');
[z, meta] = get_z(t, p);
rho = meta(:, 1);
r = meta(:, 2);
T_z = meta(:, 3);
I_z = meta(:, 4);
disp('Model run complete.  Beginning plotting...');

disp('Plotting particle properties vs time...');
figure(1);
subplot(3, 1, 1); hold on;
plot(t, z, 'DisplayName', 'particle track');
set(gca, 'ydir', 'reverse');
ylabel('depth (m)');
title(sprintf('LDPE, radius %.04g mm', r_pl*1000));

subplot(3, 1, 2);
plot(t, rho);
ylabel('particle+film density (kg m^-3)');

subplot(3, 1, 3);
plot(t, r);
ylabel('particle+film radius (m)');

disp('Plotting forcing data vs time...');
figure;
subplot(2, 1, 1)
plot(t, T_z);
ylabel('T(p.z) (deg C)');

subplot(2, 1, 2)
plot(t, I_z);
ylabel('I(p.z) (micro mol quanta m^-2 s^-1)');

if do_growth_balance_analysis
    disp('Beginning growth balance analysis...');
    [daily_t, z_balance] = get_growth_balance_depth(p, t(1), t(end));
    figure(1);
    subplot(3, 1, 1); hold on;
    plot(daily_t, z_balance, 'DisplayName', 'depth of growth balance');
    legend();
end


if show_daily_euphotic_depth
    disp('Overlaying daily mean euphotic depth vs time...');

    z_eu = view_euphotic_depth_for_t(t, p.lat, p.lon);
    days = t(1):hours(24):t(end);
    daily_mean_zeu = zeros(1, length(days)-1);
    for i=1:length(daily_zeu)
        daily_mean_zeu(i) = mean(z_eu((t > days(i)) & (t < days(i+1))));
    end

    subplot(1, 2, 1);
    plot(days(1:end-1), daily_mean_zeu);
    legend('particle depth','daily mean euphotic depth')
end