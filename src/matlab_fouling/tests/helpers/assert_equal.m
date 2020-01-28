function assert_equal(A, B, uncertainty_factor)
%ASSERT_EQUAL check two values are equal to within floating point tolerance
    if (nargin == 2)
        uncertainty_factor = 1e4*eps(min(abs(A),abs(B)));
    end
    assert(abs(A-B) < uncertainty_factor);
end
