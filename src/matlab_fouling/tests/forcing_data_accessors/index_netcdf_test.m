test_single_extraction();
test_multiple_extraction();

function test_single_extraction()
    lon = 1;
    lat = -31;
    depth = 5;
    time = (datenum(2015, 2, 1) - datenum(2000, 1, 1))*24;  % hours since 2000-01-01
    A = index_netcdf('./test.nc', 'salinity', lon, lat, depth, time);
    B = 35.914;
    
    assert_equal(A, B, 1e-3);
end

function test_multiple_extraction()
    lon = [0, 1, 2];
    lat = [-29, -30, -30];
    depth = [12, 10, 6];
    feb1 = (datenum(2015, 2, 1) - datenum(2000, 1, 1))*24;  % hours since 2000-01-01
    mar1 = (datenum(2015, 3, 1) - datenum(2000, 1, 1))*24;  % hours since 2000-01-01
    time = [mar1, mar1, feb1];
    A = index_netcdf('./test.nc', 'water_temp', lon, lat, depth, time);
    B = [22.022, 21.763, 22.046];  % extracted directly from test.nc
    for i=1:3
        assert_equal(A(i), B(i), 1e-3);
    end
end
