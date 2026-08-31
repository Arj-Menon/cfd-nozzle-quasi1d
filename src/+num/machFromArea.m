function M = machFromArea(AR, branch, gam)
%MACHFROMAREA invert A/A* to Mach Number on a chosen branch.
% AR- Area Ratio A/A*, must be >= 1
% branch- subsonic 'sub' or supersonic 'sup'
% gam - ratio of specific heats
    % A/A* has a minium of 1 at the throat, below that, no root is possible
    % on either branches i.e. physically impossible.
    if AR < 1
        error('machFromArea: A/A* = %.6f is below 1, no solution exists', AR);
    end
    % Defining function to find 'ar - AR = 0'
    g = @(M) gd.ar(M, gam) - AR;

    % Picking the bracket, This is the only place where the branch is used,
    % and it makes the non-invertible function invertible.
    switch branch 
        case 'sub'
            lo = 1e-6; % not 0 - ar has a 1/M in it and would blow up 
            hi = 1;
        case 'sup'
            lo = 1;
            hi = 25; % physically well beyond any nozzle
        otherwise 
            error('machFromArea: branch must be ''sub'' or ''sup''.');
    end 
    M = num.bisect(g,lo,hi,1e-12);
end 
