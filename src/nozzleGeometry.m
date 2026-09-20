function geom = nozzleGeometry()
% NOZZLEGEOMETRY NASA NPARC converging-dverging nozzle, cosine are law. 
% Returns a struct bundling the area law, its inverse, and key stations.
% Area in in^2, axial position x in inches for 0 <= x <= 10.
    geom.xInlet = 0;
    geom.xThroat = 5;
    geom.xExit = 10;

    geom.Ai = 2.5; % Inlet Area [in^2]
    geom.At = 1; % Throat Area [in^2]
    geom.Ae = 1.5; % Exit Area [in^2]

    geom.A = @areaAt; % handle to forward law
    geom.xFromArea = @xFromAreaAt;
end

function A = areaAt(x)
% Forward law, works on a single x or a while array of them.
theta = (0.2 .* x -1).* pi;
A = zeros(size(x)); % Making Matlab make the array containing x elemts and assigning 0 value to each.
conv = (x<5); % true when we are upstream of the throat; conv function takes the values in the matrix true to the condition.
A(conv) = 1.75 - 0.75 .* cos(theta(conv));
A(~conv) = 1.25 - 0.25 .* cos(theta(~conv));
end 

function x = xFromAreaAt(A,section)
% Inverse Law, 'section' resolves the 2-x-per area ambiguity.
    switch section
        case 'conv'
            c = (1.75 - A)./ 0.75; % Converging half sits on negative theta
            sgn = -1;
        case 'div' 
            c = (1.25 - A)./ 0.25; % Diverging half is what cos inv (acos) returns
            sgn = +1;
        otherwise
            error ('xFromArea: section must be ''conv'' or ''div''.');
    end
    % acos of anything outside [-1,1] returns a complex number silently.
    % An area outside the section's range is a real error - say so 
    if any(abs(c) > 1 + 1e-9)
        error ('xFromArea: area %.6f is outside the %s section.', A, section);
    end 
    c = max (-1 , min(1,c)); % Clamps the value between [-1 , 1]
    x = 5 + sgn .* (5 ./ pi).* acos(c);
end
