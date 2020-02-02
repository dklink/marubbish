function I = I_vs_time(second_of_day)
    % kooi's parameterization of daylight intensity
    hour_of_day = second_of_day/3600;
    I = kooi_constants.I_m * sin((2*pi) * (hour_of_day-6)/24);
    I(I < 0) = 0;
end

%{
% Testing I_vs_time

t_hours = linspace(0, 24);
t_seconds = t_hours*60*60;

I = I_vs_time(t_seconds);
plot(t_hours, I);
yline(kooi_constants.I_m);
%}