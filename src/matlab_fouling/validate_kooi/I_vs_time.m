function I = I_vs_time(second)
    hour = second/3600;
    I = kooi_constants.I_m * sin((2*pi) * hour/24);
    I(I < 0) = 0;
end