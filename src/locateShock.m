function shock = locateShock(pe_p01, geom, gam)
% LOCATESHOCK  Find the normal shock position for a given back pressure.
%   Assumes the 'shock' regime has already been confirmed by classifyRegime.
%   Returns a struct with Me, p02_p01, M1, M2, Ashock, xShock, Astar2.

    % --- Step 1: exit Mach, CLOSED FORM via the F(M) collapse ------------
    % The A* identity p01*A*1 = p02*A*2 with A*1 = A_t lets the exit
    % condition be written entirely in p01 and A_t, so both unknowns
    % cancel and F is computable BEFORE the shock is located.
    Fe      = pe_p01 .* (geom.Ae ./ geom.At);
    Me      = gd.machFromF(Fe, gam);

    % --- Step 2: total pressure loss, algebraic --------------------------
    p02_p01 = pe_p01 ./ gd.pp0(Me, gam);

    % --- Step 3: upstream Mach, THE ONLY ITERATION ----------------------
    % p02/p01 is transcendental in M1. It decreases monotonically from 1
    % at M1 = 1, so a sign change on [1, 25] is guaranteed.
    g  = @(M) gd.p0ratio(M, gam) - p02_p01;
    M1 = num.bisect(g, 1, 25, 1e-12);

    % --- Step 4: everything else is algebra ------------------------------
    Ashock = geom.At .* gd.ar(M1, gam);
    xShock = geom.xFromArea(Ashock, 'div');
    Astar2 = geom.At ./ p02_p01;
    M2     = num.machFromArea(Ashock ./ Astar2, 'sub', gam);

    shock = struct('Me', Me, 'p02_p01', p02_p01, 'M1', M1, 'M2', M2,'Ashock', Ashock, 'xShock', xShock, 'Astar2', Astar2);
    shock = struct('Me', Me, 'p02_p01', p02_p01, 'M1', M1, 'M2', M2,'Ashock', Ashock, 'xShock', xShock, 'Astar2', Astar2);
end