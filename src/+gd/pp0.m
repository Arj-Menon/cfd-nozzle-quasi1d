function PR = pp0(M,gam)
% PP0 Isentropic static-to-stagnation pressure ratio p/p0.
% Returns a value <= 1 always, take 1./pp0 for anderson's p0/p.

PR = ( 1 + ((gam -1)./2).*M.^2).^ (-gam ./ (gam -1));
end 
