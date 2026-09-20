function PR = p0ratio(Mx, gam)
% P0RATIO  Total pressure ratio p02/p01 across a normal shock.
%   Mx is upstream Mach. Returns a value <= 1 - a shock always destroys
%   total pressure. Monotonically DECREASING in Mx, which is what makes
%   the inverse bisectable.

    term1 = ( ((gam+1).*Mx.^2) ./ (2 + (gam-1).*Mx.^2) ) .^ ( gam ./ (gam-1) );
    term2 = ( (gam+1) ./ ((2.*gam).*Mx.^2 - (gam-1)) ) .^ ( 1 ./ (gam-1) );
    PR    = term1 .* term2;
end