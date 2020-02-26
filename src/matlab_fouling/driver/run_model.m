t = datetime(2015, 1, 1, 0, 0, 0):hours(.5*pi):datetime(2016, 1, 1, 0, 0, 0);
r_pl = .0001;
p = Particle(r_pl, kooi_constants.rho_LDPE, 0, constants.NP_lat, constants.NP_lon, 0);

disp(['Salinity forcing: ' Paths.salinity]);
disp(['Temperature forcing: ' Paths.temperature]);
disp(['Surface Chlorophyll forcing: ' Paths.chlorophyll]);

%view_world_light_at_location(p.lat-60, p.lon+100, t(15));

z = get_z(t, p);

figure(1); hold on;
plot(t, z);
set(gca, 'ydir', 'reverse');
ylabel('depth (m)');
title(sprintf('LDPE, radius %.02f mm', r_pl*1000));

z_eu = view_euphotic_depth_for_t(t, p.lat, p.lon);
days = t(1):hours(24):t(end);
daily_mean_zeu = zeros(1, length(days)-1);
for i=1:length(daily_zeu)
    daily_mean_zeu(i) = mean(z_eu((t > days(i)) & (t < days(i+1))));
end

figure(1);
plot(days(1:end-1), daily_mean_zeu);
legend('particle depth','daily mean euphotic depth')