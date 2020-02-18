function I = I_vs_time(second_of_day)
    % kooi's parameterization of daylight intensity
    t = second_of_day/constants.seconds_per_day;
    I = kooi_constants.I_m * sin((2*pi) * t);
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