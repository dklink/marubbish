%kooi fig 1
seconds_per_hour = 3600;
seconds_per_day = seconds_per_hour*24;
hours_per_week = 24*7;

NP_lat = 25.428321;   % lat and lon of spot near hawaii
NP_lon = -151.773256; %

particle_radius = .001;
p = Particle(particle_radius, 920, 5e6, NP_lat, NP_lon, 0);
dt = seconds_per_hour*1;
tspan = 0:dt:1000*seconds_per_day;

z0 = 0;
[t,z] = ode23(@(t,z) odefcn(t, z, p, dt), tspan, z0);
plot(t, z);

%{
dt_hours = 4;  % this seems to be granular enough
dt = seconds_per_hour*dt_hours;
hours = 1:dt_hours:2400;   % 100 days, time step every dt_hours
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
    
    % this right below is a terrible hack of physics -- I need to properly
    % solve the diff equation to get position
    V_s = .9*V_s + get_settling_velocity(p, S_z, T_z);
    
    p.z = p.z + V_s * dt;
    if p.z < 0  % silly particle, you can't fly
        p.z = 0;
    end
    rho(i) = p.rho_tot;
    z(i) = p.z;
    A(i) = p.A;
end

figure
plot(hours/24, A);
xlabel('days');
ylabel('algae count');
figure
plot(hours/24, z);
xlabel('days');
ylabel('depth (m)');
set(gca, 'YDir','reverse');
figure
plot(hours/24, rho);
xlabel('days');
ylabel('density (kg m^{-3})');
%}
