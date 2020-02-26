t = datetime(2015, 1, 1, 0, 0, 0):hours(.25*pi):datetime(2020, 1, 1, 0, 0, 0);
r_pl = .1 * 1e-3; %mm
%lat = constants.NP_lat;
lat = -47.279229;
%lon = constants.NP_lon;
lon = -61.171875;
p = Particle(r_pl, kooi_constants.rho_LDPE, 0, lat, lon, 0);

disp(['Salinity forcing: ' Paths.salinity]);
disp(['Temperature forcing: ' Paths.temperature]);
disp(['Surface Chlorophyll forcing: ' Paths.chlorophyll]);

z = get_z(t, p);

figure; hold on;
plot(t, z);
set(gca, 'ydir', 'reverse');
ylabel('depth (m)');
title(sprintf('LDPE, radius %.04g mm', r_pl*1000));
%{
z_eu = view_euphotic_depth_for_t(t, p.lat, p.lon);
days = t(1):hours(24):t(end);
daily_mean_zeu = zeros(1, length(days)-1);
for i=1:length(daily_zeu)
    daily_mean_zeu(i) = mean(z_eu((t > days(i)) & (t < days(i+1))));
end

figure(1);
plot(days(1:end-1), daily_mean_zeu);
legend('particle depth','daily mean euphotic depth')
%}