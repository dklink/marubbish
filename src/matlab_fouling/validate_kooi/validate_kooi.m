%kooi fig 1
seconds_per_hour = 3600;
seconds_per_day = seconds_per_hour*24;
hours_per_week = 24*7;

NP_lat = 25.428321;   % lat and lon of spot near hawaii
NP_lon = -151.773256; %

particle_radius = .001;
p = Particle(particle_radius, kooi_constants.rho_LDPE, 0, NP_lat, NP_lon, 0);

dt_hours = 1;  % this needs to be like .1 * period of oscillation for good accuracy
dt = seconds_per_hour*dt_hours;
num_days = 110;
hours = 1:dt_hours:num_days*24;
A = zeros(1, length(hours));
z = zeros(1, length(hours));
rho = zeros(1, length(hours));

chl_surf = .05;
chl_ave = .151;
z(1) = p.z;
A(1) = p.A;
rho(1) = p.rho_tot;
V_s = 0;
for i=2:length(hours)
    I_surf = I_vs_time(hours(i));
    T_z = T_vs_z(p.z);
    I_z = get_light_at_z(p.z, I_surf, chl_ave);
    S_z = S_vs_z(p.z);
    dAdt = get_algae_flux_for_particle(p, S_z, T_z, chl_surf, I_z);
    
    p.A = p.A + dAdt * dt;
    
    % not sure if this properly approximates the physics
    V_s = get_settling_velocity(p, S_z, T_z);
    
    p.z = p.z + V_s * dt;
    if p.z < 0  % silly particle, you can't fly
        p.z = 0;
    end
    rho(i) = p.rho_tot;
    z(i) = p.z;
    A(i) = p.A;
end

% plot just days 100-110
%{
A = A(hours/24 > 100);
z = z(hours/24 > 100);
rho = rho(hours/24 > 100);
hours = hours(hours/24 > 100);
%}

figure
plot(hours/24, z);
xlabel('days');
ylabel('depth (m)');
set(gca, 'YDir','reverse');
title(sprintf('radius = %.1fmm', particle_radius*1000));
ylim([0, 60]);

%{
set(0, 'DefaultLineLineWidth', 2);
figure
plot(hours/24, A);
xlabel('days');
ylabel('algae count');
title(sprintf('radius = %.1fmm', particle_radius*1000));


figure
plot(hours/24, rho);
xlabel('days');
ylabel('density (kg m^{-3})');
title(sprintf('radius = %.1fmm', particle_radius*1000));
%}

% was trying to get an ode to work since kooi says she did this
%{
tspan = 0:dt:1000*seconds_per_day;

z0 = 0;
[t,z] = ode23(@(t,z) odefcn(t, z, p, dt), tspan, z0);
plot(t, z);
%}
