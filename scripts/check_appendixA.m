% check appendixA.m
% It reproduces one row of Anderson's Appendix A (isentropic, gamma = 1.4)
clear; clc
M = 1.61; % Mach Number of the table row we want 
gam = 1.4; % ratio of specific heats for air

% Stagnation Temperature ratio 
% T/T0 = 1 / [1 + ((gam-1)/2) * M^2)]; so T0/T is the reciprocal 
tt0 = 1 ./ ( 1+ ((gam -1)./2) .*M.^2);

% Isentropic + Perfect gas ---> p/p0 = (T/T0)[gam/(gam -1)]
pp0 = tt0 .^( gam ./(gam -1));

% and Density rho/rho0 = (T/T0)^[1/(gam -1)]
rr0 = tt0 .^(1 ./ (gam -1));

% Area-Mach Relation
% A/A* = (1/M) * { [2/(gam+1)] * [1 + ((gam-1)/2)*M^2] } ^ [(gam+1)/(2*(gam-1))]
ar = (1./M).*( (2./(gam+1)) .* ( 1 + ((gam -1)./2)*M.^ 2)).^((gam +1)./ (2.*(gam -1)));

fprintf('M =  %.3f\n', M);
fprintf('p0/p = %.4f\n', 1./pp0);
fprintf('rho/rho0 = %.4f\n', 1./rr0);
fprintf('T0/T = %.4f\n', 1./tt0);
fprintf('A/A* = %.4f\n', ar);
