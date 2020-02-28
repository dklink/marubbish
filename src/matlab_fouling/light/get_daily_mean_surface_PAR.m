function daily_PAR = get_daily_mean_surface_PAR(lat, lon, t_start, t_end)
%GET_DAILY_MEAN_SURFACE_PAR Summary of this function goes here
%   lat: deg N
%   lon: deg E
%   t_start: datetime
%   t_end: datetime
    t = datetime(year(t_start), month(t_start), day(t_start), 0, 0, 0):hours(1): ...
        datetime(year(t_end), month(t_end), day(t_end), 23, 0, 0);
    % length(t) is exact multiple of 24
    hourly_PAR = get_surface_PAR(lat, lon, t);
    daily_PAR = mean(reshape(hourly_PAR, [24, length(t)/24]), 1);
end

