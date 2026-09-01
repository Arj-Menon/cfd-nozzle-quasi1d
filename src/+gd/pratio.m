function PR = pratio(Mx, gam)
% PRATIO Static pressure ratio Py/Px across a normal shock.
% Mx is the upstream (supersonic) Mach Number. Returns a value >= 1.

PR = 1 + ((2.*gam)./(gam + 1)) .* (Mx .^2 -1);
end
