test_matches_gsw_demo()
disp("All Tests Passed");

function test_matches_gsw_demo()
    % test to see if input from gsw demo --> output from gsw demo
    lat = 0;
    lon = 0;
    
    % inputs from gsw demo:
    SP = [ 34.5759  34.2870  34.5888  34.6589  34.6798  34.6910  34.6956 ]; % g / kg
    t  = [ 19.5076   3.6302   1.9533   1.5661   1.4848   1.4989   1.5919 ];  % celsius
    p  = [       0     1010     2025     3045     4069     5098     6131 ];  % dbar
    z = -1 * gsw_z_from_p(p, lat); % we treat z as positive
    
    % output rho from gsw demo, kg m^-3
    B = [ 1024.5709  1031.9377  1037.0031  1041.6695  1046.1799  1050.5915 1054.9014 ]; 
    
    A = get_seawater_density(SP, t, lat, lon, z);  % my output rho
    
    for i=1:length(SP)
        assert_equal(A(i), B(i), .1);  % precision isn't perfect with so much computation
    end
end