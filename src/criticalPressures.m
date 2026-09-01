function crit = criticalPressures(geom, gam)
% CRITICALPRESSURES The 3 critical back-pressure ratios for a nozzle.
% Depends on Geometry and gamma only - no back-pressure enters. These are
% properties of the hardware, unchanged by what plenum you bolt it to. 

ARexit = geom.Ae ./ geom.At; % at every critical the nozzle is choked, so A* = A_t and A_e/A* = A_e/A_t

% 1st Critical; Throat just reaches sonic, exit is still subsonic. Highest
% back pressure 
crit.Me1 = num.machFromArea(ARexit, 'sub', gam);
crit.p1 = gd.pp0(crit.Me1 ,gam);

% 3rd Critical; design, same area ratio, supersonic branch. Lowest back
% pressure
crit.Me3 = num.machFromArea(ARexit, 'sup', gam);
crit.p3 = gd.pp0(crit.Me3, gam);

% 2nd Critical; normal shock standing exactly at the exit plane. Flow is supersonic all the way down, 
% so the PRE-shock state is the design state. The shock then jumps static
% pressure at fixed area.
crit.Mx2 = crit.Me3; % pre-shock mach 
crit.p2 = gd.pratio(crit.Mx2, gam) * crit.p3;

% to check for fail condition; p3 < p2 < p1 
    if ~(crit.p3 < crit.p2 && crit.p2 < crit.p1)
    error('criticalPressures: ordering violated, p3 < p2 < p1 expected');
    end
end 
