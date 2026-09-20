function Me = machFromF(F, gam)
% MACHFROMF  Invert the F(M) collapse to Mach number. CLOSED FORM.
%   F(M) = [p/p0](M) * [A/A*](M). For gam = 1.4 this collapses to
%   F = 1 / [ 1.728 * M * sqrt(1 + 0.2*M^2) ], which is quadratic in M^2.
%   Returns the SUBSONIC root - the only one physical downstream of a shock.

    if gam ~= 1.4
        error('machFromF: closed form derived for gam = 1.4 only.');
    end

    % Let u = M^2. Squaring 1/(1.728*M*sqrt(1+0.2*M^2)) = F and
    % rearranging gives   0.2*u^2 + u - (1/(1.728*F))^2 = 0
    c = ( 1 ./ (1.728 .* F) ) .^ 2;

    % Quadratic formula on 0.2*u^2 + 1*u - c = 0.
    % Only the + root is positive, and u = M^2 must be positive.
    u = ( -1 + sqrt( 1 + (4 .* 0.2 .* c) ) ) ./ (2 .* 0.2);

    Me = sqrt(u);
end