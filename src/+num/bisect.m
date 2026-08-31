function root = bisect(f,a,b,tol)
% BISECT Find a root of f(x) = 0 between a and b by repeated halving.
% f - function handle 
% a , b - bracket endpoints; f(a) and f(b) must have opp signs 
% tol - stop once the bracket is narrower than this 
% root - midpoint of the final bracket 

fa = f(a); %value at the left end 
fb = f(b); %value at the right end 
    % Guard: same sign at both ends means no guarentted crossing inside 
    % Without this santiy check the loop keeps running and returns a number
    % that is meaningless. so better to refuse it.
    if fa .* fb > 0 
        error('bisect: f(a) and f(b) have the same sign, no root bracketed.');
    end

    while (b - a) > tol
        m = (a+b) ./ 2; % midpoint guess
        fm = f(m); % too high or too low?

        if fa .* fm <= 0 % sign flips bet a and m, so root is in the left half
            b = m; % pull the right end to the mnidpoint 
        else  % no flip in the signs, so root is in the right half 
            a =m; % push left end to the midpoint 
            fa = fm; % and remember its value for the next comparison
        end
    end

    root = (a + b) ./ 2;
end
