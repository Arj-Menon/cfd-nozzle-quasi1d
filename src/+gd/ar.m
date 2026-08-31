function AR = ar(M, gam)
%AR Isentropic area ratio A/A* at Mach Number M.
% Valid on both branches. Returns 1 at M = 1.

AR = (1./M) .* ( (2./(gam +1)) .* (1 + ((gam -1)./2).*M.^2)) .^((gam+1)./(2*(gam -1)) ); 
end